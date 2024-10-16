import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/screens/address_screen.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/placeBid.dart';
import 'package:project/widget/cart_cardlist_Widget.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isVisible = false;
  bool isTotalVisible = false;
  Map<String, dynamic> _applied_filters = {
    'code': '',
    'status': null,
    'minPrice': 300.0,
    'maxPrice': 1500000.0
  };

  Future<String> getJson() {
    return rootBundle.loadString("assets/data/cartItems.json");
  }

  List<dynamic> _products = [];
  List<dynamic> _filteredProducts = [];
  final _searchController = TextEditingController();

  void _loadData() async {
    String jsonString = await getJson();
    List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      _products = jsonData;
      _filteredProducts = jsonData;
    });
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((item) {
        return item["title"].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  num _calculate_subtotal() {
    num total = 0;
    for (var item in _products) {
      total = total + item['line_total'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
        elevation: 0,
        centerTitle: false,
        leadingWidth: 0,
        title: Container(
          // height: 34,
          alignment: Alignment.topLeft,
          width: 140,
          margin: EdgeInsets.only(left: 0),
          child: SvgPicture.asset(
            'assets/image/logo.svg',
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            child: Container(
              height: 24,
              width: 24,
              margin: EdgeInsets.only(right: 20),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "MY CART",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                    child: Row(
                      children: [
                        Center(
                          child: FaIcon(
                            FontAwesomeIcons.sliders,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: Container(
                color: Color(0xffF5F5F5),
                margin: EdgeInsets.only(top: 10),
                child: _filteredProducts.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: CustomCartCardListWidget(
                                product: _filteredProducts[index]),
                          );
                        },
                      )
                    : Center(
                        child: Text('No Data found.'),
                      ),
              ),
            ),
          ),
          Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
              border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
            padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(bottom: 5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isTotalVisible = !isTotalVisible;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cart Totals',
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
                if (isTotalVisible)
                  Column(
                    children: [
                      Center(
                        child: Container(
                          height: 1,
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        width: screenWidth,
                        padding: EdgeInsets.only(bottom: 5),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add a Coupon',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ),
                      if (isVisible)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: screenWidth * .6,
                              height: 40,
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: "Enter the Coupon Code",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5, left: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(
                                      color: Color(0xff7A7A7A),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(
                                      color: Color(0xff7A7A7A),
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(
                                      color: Color(0xff7A7A7A),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(
                                      color: Color(0xff7A7A7A),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                child: Container(
                                  height: 40,
                                  width: screenWidth * .25,
                                  child: Center(
                                    child: Text(
                                      "Apply",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      Center(
                        child: Container(
                          height: 1,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "JOD " + _calculate_subtotal().toString(),
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Shipping",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Work Sans",
                              ),
                            ),
                            Text(
                              "Free",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Work Sans",
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: screenWidth,
                          child: InkWell(
                              child: Text(
                            "Free Shipping",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: "Work Sans",
                            ),
                          ))),
                      Container(
                        // margin: EdgeInsets.only(top: 5),
                        width: screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Shipping to",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Work Sans",
                              ),
                            ),
                            Text(
                              "Rajsathan, India",
                              style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: screenWidth,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            AddressScreen())));
                              },
                              child: Text(
                                "Change Address",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Work Sans",
                                    decoration: TextDecoration.underline),
                              ))),
                      Center(
                        child: Container(
                          height: 1,
                          margin: EdgeInsets.only(top: 5),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "JOD " + _calculate_subtotal().toString(),
                        style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => BidOrder())));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    child: Container(
                      height: 50,
                      width: screenWidth,
                      child: Center(
                        child: Text(
                          "Proceed to Checkout",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Work Sans",
                              fontSize: 16),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
