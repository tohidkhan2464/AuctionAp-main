import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/widget/bottomsheet.dart';
import 'package:project/widget/customcardlistwidget.dart';

class MyGridView extends StatefulWidget {
  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  Map<String, dynamic> _applied_filters = {
    'code': '',
    'digits': null,
    'minPrice': 0.0,
    'maxPrice': 100000.0
  };

  List<dynamic> _products = [];
  List<dynamic> _filteredProducts = [];
  bool _isLoading = false;

  final ApiService _apiService = ApiService();
  void _getProducts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userId = await ApiService.getdata('ID');
      final response = await _apiService.fetchProductlistnew(
          'license-plate', userId.toString());
      DateTime currentDate = DateTime.now();
      List<dynamic> filteredItems = response.where((item) {
        DateTime itemDate = DateTime.parse(item['auction_end_new']);
        return itemDate.isAfter(currentDate) ||
            itemDate.isAtSameMomentAs(currentDate);
      }).toList();
      setState(() {
        _products = filteredItems;
        _filteredProducts = filteredItems;
        _isLoading = false;
      });
    } catch (e) {
      print('_products failed : $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    if (!mounted) return;
    _getProducts();
  }

  void _applyFilter(Map<String, dynamic> filters) {
    setState(() {
      _applied_filters = filters;
      _isLoading = true;
      _filteredProducts = _products.where((product) {
        bool matches = true;

        if (filters['code'] != null && filters['code'].isNotEmpty) {
          matches =
              matches && product['post_title'].startsWith(filters['code']);
        }

        if (filters['digits'] != null) {
          int digitCount = product['post_title'].split('-').last.length;
          switch (filters['digits']) {
            case 'ONE DIGIT':
              matches = matches && digitCount == 1;
              break;
            case 'TWO DIGIT':
              matches = matches && digitCount == 2;
              break;
            case 'THREE DIGIT':
              matches = matches && digitCount == 3;
              break;
            case 'FOUR DIGIT':
              matches = matches && digitCount == 4;
              break;
            case 'FIVE DIGIT':
              matches = matches && digitCount == 5;
              break;
          }
        }

        double price =
            double.tryParse(product['current_price'].toString()) ?? 0.0;
        matches = matches &&
            price >= filters['minPrice'] &&
            price <= filters['maxPrice'];

        return matches;
      }).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "LICENCE PLATES",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return CustomBottomSheet(
                          onFilter: (_applied_filters) {
                            _applyFilter(_applied_filters);
                          },
                          initialFilters:
                              _applied_filters, // Pass initial filters here
                        );
                      },
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.all(0),
                      // margin: EdgeInsets.only(bottom: 10),
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 2),
                          child: const Row(
                            children: [
                              Center(
                                  child: FaIcon(
                                FontAwesomeIcons.sliders,
                                color: Colors.black,
                                size: 22,
                              )),
                            ],
                          ))),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredProducts.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.only(
                          bottom: 30,
                        ),
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: CardListWidget(
                                product: _filteredProducts[index]),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'No live auctions available.',
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
