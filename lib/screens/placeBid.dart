import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/screens/about.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/licenseplate.dart';
import 'package:project/screens/mobilenumber.dart';
import 'package:project/screens/profilesscreen.dart';
import 'package:project/utils/size_utils.dart';

class BidOrder extends StatefulWidget {
  const BidOrder({super.key});

  @override
  State<BidOrder> createState() => _BidOrderState();
}

class _BidOrderState extends State<BidOrder> {
  bool _rememberMe = false;
  final _starting_price = '800';
  var _final_payment = '800';
  // TextEditingController _CreditCardController = TextEditingController();
  // TextEditingController _creditCVVNumberController = TextEditingController();
  // final TextEditingController _bidPriceController = TextEditingController();
  // double _extractNumericValue() {
  //   String text = _bidPriceController.text;
  //   double? bidPrice = double.tryParse(text);
  //   if (bidPrice != null) {
  //     return bidPrice;
  //   } else {
  //     return 0;
  //   }
  // }

  // bool _visibilityText = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff5f5f5),
      endDrawer: Container(
        margin: EdgeInsets.only(top: 30),
        child: Drawer(
          backgroundColor: Color(0xff181816),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 50,
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icon/home2.png',
                  width: 30,
                  color: Colors.grey,
                ),
                title: Text(
                  'Home Page',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => HomePage())));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icon/licenceplate.png',
                  width: 30,
                  color: Colors.grey,
                ),
                title: Text(
                  'Licence Plate',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => LicencePlate())));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icon/mobile.png',
                  width: 30,
                ),
                title: Text(
                  'Mobile Number',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => MobileNumber())));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icon/about.png',
                  width: 30,
                ),
                title: Text(
                  'About',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => AboutScreen())));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icon/profile.png',
                  width: 30,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ProfileScreen())));
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
          child: AppBar(
            backgroundColor: Color(0xffF5F5F5),
            elevation: 0,
            centerTitle: false,
            leadingWidth: 40,
            title: Container(
              // height: 34,
              alignment: Alignment.topLeft,
              width: 140,
              // margin: const EdgeInsets.only(left: 20),
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
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Your Order',
            style: TextStyle(
                fontFamily: "Work Sans",
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 20),
          width: screenWidth * 1,
          child: Row(
            children: [
              Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xff4d4d4d),
                ),
              ),
              Container(
                width: screenWidth - 92,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            '0795763000',
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                          child: Text(
                            'JOD 999',
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 0),
                      child: Text(
                        'QUANTITY: 1',
                        style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 8,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Center(
          child: Container(
            // width: ,
            height: 1,
            color: Colors.grey,
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 20,
                top: 5,
              ),
              child: Text(
                'Starting Price',
                style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 5, right: 20),
              child: Text(
                'JOD ' + _starting_price,
                style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Bid Price',
                style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              height: 20,
              width: 70,
              margin: EdgeInsets.only(right: 20),
              padding: EdgeInsets.zero,
              child: TextFormField(
                onChanged: (text) {
                  double? bidPrice = double.tryParse(text);
                  if (bidPrice != null) {
                    _final_payment =
                        (bidPrice + double.parse(_starting_price)).toString();
                  } else {
                    _final_payment =
                        (0 + double.parse(_starting_price)).toString();
                  }
                },
                style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Color(
                          0xff7A7A7A), // Change this to your desired border color
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Color(
                          0xff7A7A7A), // Change this to your desired focused border color
                      width: 1.0, // Change the width if needed
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Color(
                          0xff7A7A7A), // Change this to your desired error border color
                      width: 1.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Color(
                          0xff7A7A7A), // Change this to your desired focused error border color
                      width: 1.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20),
              child: Text(
                'Final Payment',
                style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20),
              child: Text(
                _final_payment,
                style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        Center(
          child: Container(
            height: 1,
            color: Colors.grey,
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
            child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => checkoutbidpg())));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                  // width: screenWidth * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Choose Payment Method",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.black26,
                              size: 20,
                            )),
                      ]),
                ))),
        SizedBox(height: 20.v),
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Row(children: [
            Container(
              child: Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors
                              .white; // Color of the checkbox when checked
                        }
                        return Colors.grey.withOpacity(
                            0.4); // Color of the checkbox when unchecked
                      },
                    ),
                    activeColor:
                        Colors.white, // Color of the checkbox when checked
                    checkColor: Colors.black,
                  ),
                  Text(
                    "I Have Read and Agree to the website ",
                    style: TextStyle(
                      fontFamily: "Roboto Sans",
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      "Terms And Conditions*",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: "Roboto Sans",
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
        Center(
            child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => checkoutdetailpg())));
                },
                child: Container(
                  margin:
                      EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 40),
                  // width: screenWidth * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                )))
      ]),
    );
  }
}
