import 'package:flutter/material.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/licenseplate.dart';
import 'package:project/screens/mobilenumber.dart';
import 'package:project/screens/profilesscreen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
            //   child: AppBar(
            //     backgroundColor: Color(0xffF5F5F5),
            //     elevation: 0,
            //     title: Row(
            //       children: [
            //         Flexible(
            //           child: Image.asset(
            //             'assets/image/splash.png',
            //             fit: BoxFit.contain,
            //             height: 34,
            //           ),
            //         ),
            //       ],
            //     ),
            //     automaticallyImplyLeading: false,
            //     actions: [
            //       Container(
            //         margin: EdgeInsets.only(right: 15),
            //         child: IconButton(
            //           icon: Icon(
            //             Icons.menu,
            //             color: Colors.black,
            //             size: 26,
            //           ),
            //           onPressed: () {
            //             _scaffoldKey.currentState?.openEndDrawer();
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: screenWidth * .9,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "About Us",
                              style: TextStyle(
                                  fontFamily: "Work Sans",
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          "RAQAMAK is an independently owned establishment that was founded in Jordan in  August 2020. We are specialized in premium numbers dealership either premium plate numbers or premium mobile numbers.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Work Sans',
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 5),
                            child: Text("Our Mission",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          "Our mission is to re-align the concept of buying or selling premium numbers in Jordan from dealers and traditional concept into more authentic, prefessionally yet easy process.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Work Sans',
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 5),
                            child: Text(
                              "Our Vision",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          "Our vision based on our personal experience as dealers in many different segments in the market built the thrive in us to make investing dealership a better community for everyone.\nAn easy straight forward process starting from the call button to the congratulation hand shake point, we are building this platform gathering each and every PREMIUM number owner in one place with into details from our Driver and Vehicle licensing department in Jordan as well as for our main telecommunication companies to make every Selling and Buying process an easy and straight forward one.\nAt RAQAMAK, we continue to grow by the day. And we are always passionate to partner with top JORDANIAN after sale service providers. We look forward to hearing from you and building a mutually beneficial business partnership.\n",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Work Sans',
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
