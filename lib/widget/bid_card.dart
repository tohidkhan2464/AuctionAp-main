import 'package:flutter/material.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/widget/bid_cardlist_Widget.dart';

class BidCard extends StatefulWidget {
  const BidCard({super.key});

  @override
  State<BidCard> createState() => _BidCardState();
}

class _BidCardState extends State<BidCard> {
  List<dynamic> _products = [];
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  void _getProducts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userid = await ApiService.getdata('ID');
      final response = await _apiService.fetchAuctions(userid.toString());
      print("RESPONSE 1 $response");
      setState(() {
        _products = response;
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    if (_isLoading) {
      return Container(
        height: screenHeight * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_products.isEmpty) {
      return Container(
        height: screenHeight * .5,
        child: const Center(
          child: Text(
            'Make your first bid to see your auctions here!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Work Sans",
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
        itemCount: _products.length > 3 ? 3 : _products.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: CustomBidCardListWidget(product: _products[index]),
          );
        },
      );
    }
  }
}
