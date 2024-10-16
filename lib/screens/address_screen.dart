import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/screens/about.dart';
import 'package:project/screens/edit_billing_info.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/licenseplate.dart';
import 'package:project/screens/mobilenumber.dart';
import 'package:project/screens/profilesscreen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool isShippingInfoAvailable = false;
  bool isBillingInfoAvailable = false;
  String _billingName = "";
  String _shippingName = "";
  String _street = "";
  String _billingAddress = "";
  String _town = "";
  String _state = "";
  String _zip = "";
  String _mobile = "";
  String _email = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => AboutScreen())));
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => HomeScreen())));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello User,",
                style: TextStyle(
                    fontFamily: "Work Sans", fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * .9,
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(8),
                child: Text(
                  "Manage your shopping and billing addresses.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 16,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),

          // Billing Address
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 1),
                  child: Text(
                    'BILLING ADDRESS',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => EditBillingInfoScreen())));
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 2),
                        child: Text(
                          isBillingInfoAvailable ? "EDIT" : "ADD",
                          style: TextStyle(
                            fontFamily: 'Work Sans',
                            color: Colors.black26,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.black26,
                            size: 16,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),

          // Billing Info
          if (isBillingInfoAvailable)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _billingName,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _billingAddress,
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _mobile,
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _email,
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          SizedBox(
            height: 20,
          ),
          // Shipping Address
          // Container(
          //   // width: screenWidth * .9,
          //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         margin: EdgeInsets.only(left: 10, top: 1),
          //         child: Text(
          //           'SHIPPING ADDRESS',
          //           textAlign: TextAlign.left,
          //           style: TextStyle(
          //             fontFamily: "Work Sans",
          //             color: Colors.black,
          //             fontSize: 20,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ),
          //       InkWell(
          //         onTap: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: ((context) => EditShippingInfoScreen())));
          //         },
          //         child: Row(
          //           children: [
          //             Container(
          //               margin: EdgeInsets.only(right: 2),
          //               child: Text(
          //                 'ADD',
          //                 style: TextStyle(
          //                   fontFamily: 'Work Sans',
          //                   color: Colors.black26,
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //               ),
          //             ),
          //             Container(
          //                 margin: EdgeInsets.only(right: 15),
          //                 child: Icon(
          //                   Icons.arrow_forward,
          //                   color: Colors.black26,
          //                   size: 16,
          //                 )),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          //
          // // Shipping Info
          // if (isShippingInfoAvailable)
          //   Container(
          //     margin: EdgeInsets.symmetric(horizontal: 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Container(
          //             height: 100,
          //             margin: EdgeInsets.only(left: 10),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   _shippingName,
          //                   textAlign: TextAlign.left,
          //                   style: TextStyle(
          //                     fontFamily: 'Work Sans',
          //                     color: Colors.black,
          //                     fontSize: 12,
          //                   ),
          //                 ),
          //                 Text(
          //                   _street,
          //                   style: TextStyle(
          //                     fontFamily: 'Work Sans',
          //                     color: Colors.black,
          //                     fontSize: 12,
          //                   ),
          //                 ),
          //                 Text(
          //                   _town,
          //                   style: TextStyle(
          //                     fontFamily: 'Work Sans',
          //                     color: Colors.black,
          //                     fontSize: 12,
          //                   ),
          //                 ),
          //                 Text(
          //                   _state,
          //                   style: TextStyle(
          //                     fontFamily: 'Work Sans',
          //                     color: Colors.black,
          //                     fontSize: 12,
          //                   ),
          //                 ),
          //                 Text(
          //                   _zip,
          //                   style: TextStyle(
          //                     fontFamily: 'Work Sans',
          //                     color: Colors.black,
          //                     fontSize: 12,
          //                   ),
          //                 ),
          //               ],
          //             )),
          //       ],
          //     ),
          //   ),
          // if (isBillingInfoAvailable)
          //   Container(
          //     margin: EdgeInsets.symmetric(horizontal: 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Container(
          //             margin: EdgeInsets.only(left: 10),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   "Same as billing Address",
          //                   textAlign: TextAlign.left,
          //                   style: TextStyle(
          //                       fontFamily: "Work Sans",
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ],
          //             )),
          //       ],
          //     ),
          //   ),
          // if (!isBillingInfoAvailable)
          //   Container(
          //     margin: EdgeInsets.symmetric(horizontal: 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Container(
          //             margin: EdgeInsets.only(left: 10),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   "Please add billing Address first.",
          //                   textAlign: TextAlign.left,
          //                   style: TextStyle(
          //                       fontFamily: "Work Sans",
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ],
          //             )),
          //       ],
          //     ),
          //   ),
        ]));
  }
}
