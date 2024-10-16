import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/widget/auction_fee_card.dart';
import 'package:project/widget/transaction_bottom_sheet.dart';
import 'package:project/widget/winning_auction_card.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final int _itemsPerPage = 6;
  int _currentPage = 1;

  var _winningAuctionCards = [];
  String userId = '';
  var _filteredWinningAuctionCards = [];
  Map<String, dynamic> _appliedFilters = {
    'code': '',
    'transaction_type': null,
    'minPrice': 0.0,
    'maxPrice': 100000.0
  };
  bool _isLoading = false;
  Key _listViewKey = UniqueKey();
  final ApiService _apiService = ApiService();

  void _getProducts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userid = await ApiService.getdata('ID');
      final response = await _apiService.fetch_Orders(userid.toString());
      setState(() {
        _winningAuctionCards = response;
        userId = userid.toString();
        _filteredWinningAuctionCards = response;
        _currentPage = 1;
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
    _getProducts();
  }

  void _applyFilter(Map<String, dynamic> filters) {
    setState(() {
      _appliedFilters = filters;
      _isLoading = true;
      print("Filters applied: $filters");

      _filteredWinningAuctionCards = _winningAuctionCards.where((product) {
        bool matches = true;

        // Apply transaction type filter if it's not null
        if (filters['transaction_type'] != null) {
          matches =
              matches && product['order_type'] == filters['transaction_type'];
        }

        // Apply price range filter
        double price = double.tryParse(product['order_price'] ?? '0.0') ?? 0.0;
        matches = matches &&
            price >= filters['minPrice'] &&
            price <= filters['maxPrice'];

        return matches;
      }).toList();

      _currentPage = 1;
      _isLoading = false;
    });
  }

  int _totalPages(List<dynamic> items) {
    return (items.length / _itemsPerPage).ceil();
  }

  List<dynamic> _getItemsForCurrentPage(List<dynamic> items) {
    final int startIndex = (_currentPage - 1) * _itemsPerPage;
    final int endIndex = startIndex + _itemsPerPage;
    return items.sublist(
        startIndex, endIndex > items.length ? items.length : endIndex);
  }

  void _nextPage() {
    setState(() {
      _listViewKey = UniqueKey();
      if (_currentPage < _totalPages(_filteredWinningAuctionCards)) {
        _currentPage++;
      }
    });
  }

  void _previousPage() {
    setState(() {
      _listViewKey = UniqueKey();
      if (_currentPage > 1) {
        _currentPage--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5F5),
        elevation: 0,
        centerTitle: false,
        leadingWidth: 40,
        title: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            width: 140,
            // margin: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              'assets/image/logo.svg',
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        actions: [
          InkWell(
            child: Container(
              height: 24,
              width: 24,
              margin: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                "assets/icon/home2.svg",
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => HomeScreen())));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'TRANSACTIONS',
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
                        return CustomTransactionBottomSheet(
                          onFilter: (filters) {
                            _applyFilter(filters);
                          },
                          initialFilters: _appliedFilters,
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 2),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.sliders,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else ...[
            _filteredWinningAuctionCards.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      key: _listViewKey,
                      itemCount:
                          _getItemsForCurrentPage(_filteredWinningAuctionCards)
                              .length,
                      itemBuilder: (context, index) {
                        var item = _getItemsForCurrentPage(
                            _filteredWinningAuctionCards)[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: item['order_type'] != "Auction Fee"
                              ? CustomWinningCardListWidget(
                                  item: item,
                                  userId: userId,
                                )
                              : CustomAuctionCardListWidget(
                                  item: item,
                                  userId: userId,
                                ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                    child: Container(
                      width: screenWidth * .9,
                      child: const Text(
                        "No transaction has been made yet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )),
          ],
          if (!_isLoading && _filteredWinningAuctionCards.isNotEmpty)
            Container(
              width: screenWidth * .9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: _currentPage > 1 ? Colors.black : Colors.grey,
                    onPressed: _previousPage,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    style: const TextStyle(fontSize: 16),
                    'Page $_currentPage of ${_totalPages(_filteredWinningAuctionCards)}',
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    color:
                        _currentPage < _totalPages(_filteredWinningAuctionCards)
                            ? Colors.black
                            : Colors.grey,
                    onPressed: _nextPage,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
