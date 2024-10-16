import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/widget/customcardlistwidget.dart';
import 'package:project/widget/mobilebottomsheet.dart';

class MyMobileGridView extends StatefulWidget {
  const MyMobileGridView({super.key});

  @override
  _MyMobileGridViewState createState() => _MyMobileGridViewState();
}

class _MyMobileGridViewState extends State<MyMobileGridView> {
  Map<String, dynamic> _applied_filters = {
    'service_provider': '',
    'minPrice': 0.0,
    'maxPrice': 50000.0
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
          'mobile-numbers', userId.toString());
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

        if (filters['service_provider'] != null) {
          String query = filters['service_provider'].toLowerCase();
          // String? serviceProvider = product["service_provider"];
          List<dynamic> tags = product["tags"];
          matches = matches && tags.any((tag) => tag.contains(query));
          // matches = matches &&
          //     (serviceProvider != null &&
          //         serviceProvider.toLowerCase().contains(query));
        }
        double price =
            double.tryParse(product['current_price'].toString()) ?? 0.0;
        matches = matches &&
            price >= filters['minPrice'] &&
            price <= filters['maxPrice'];
        _isLoading = false;
        return matches;
      }).toList();
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
              children: [
                const Text(
                  "MOBILE NUMBER",
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
                        return MobileBottomSheet(
                          onFilter: (_applied_filters) {
                            _applyFilter(_applied_filters);
                          },
                          initialFilters: _applied_filters,
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
                        padding: const EdgeInsets.only(bottom: 30),
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: CardListWidget(
                                  product: _filteredProducts[index]));
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
