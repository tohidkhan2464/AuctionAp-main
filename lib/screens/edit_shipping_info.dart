import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '../auth/api_service.dart';
import 'package:project/screens/about.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/licenseplate.dart';
import 'package:project/screens/mobilenumber.dart';
import 'package:project/screens/profilesscreen.dart';
import 'package:project/theme/theme_helper.dart';
import 'package:project/utils/size_utils.dart';
import 'package:project/widget/custom_button.dart';

// ignore_for_file: must_be_immutable
class EditShippingInfoScreen extends StatefulWidget {
  const EditShippingInfoScreen({Key? key}) : super(key: key);

  @override
  _EditShippingInfoScreenState createState() => _EditShippingInfoScreenState();
}

class _EditShippingInfoScreenState extends State<EditShippingInfoScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _townCityController = TextEditingController();
  final _stateCountryController = TextEditingController();
  final _postCodeController = TextEditingController();
  final _streetController = TextEditingController();

  // final _firstName = "";
  // final _lastName = "";
  // final _town = "";
  // final _stateCountry = "";
  // final _postCode = "";
  // final _street = "";

  // final ApiService _apiService = ApiService();
  void _update() async {
    try {
      // final response = await _apiService.signup({
      //   "first_name": _firstNameController.text,
      //   "last_name": _lastNameController.text,
      //   "town": _townCityController.text,
      //   "state": _stateCountryController.text,
      //   "postCode": _postCodeController.text,
      //   "street": _streetController.text,
      //   "country": "Jordan",
      // });
      print('Update successful');
    } catch (e) {
      print('Update failed: $e');
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenwidth = mediaQueryData.size.width;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: appTheme.background,
        resizeToAvoidBottomInset: true,
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
          Form(
              key: _formKey,
              child: SizedBox(
                  // height: double.minPositive,
                  width: double.maxFinite,
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 18.h, right: 18.h, top: 50.v),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "SHIPPING ADDRESS",
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )),
                                  SizedBox(height: 27.v),

                                  // First
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'FIRST NAME *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14.56,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 10.v),
                                      Container(
                                        height: screenwidth <= 360 ? 30 : 45,
                                        child: TextFormField(
                                          // initialValue: _firstName,
                                          style: TextStyle(color: Colors.grey),
                                          controller: _firstNameController,
                                          autofocus: false,
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
                                                width:
                                                    1.0, // Change the width if needed
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
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(
                                                    0xff7A7A7A), // Change this to your desired focused error border color
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your username';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.v),

                                  // Last Name
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'LAST NAME *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14.56,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 10.v),
                                      Container(
                                        height: screenwidth <= 360 ? 30 : 45,
                                        child: TextFormField(
                                          // initialValue: _lastName,
                                          style: TextStyle(color: Colors.grey),
                                          controller: _lastNameController,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            // labelText: 'Last Name',
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
                                                width:
                                                    1.0, // Change the width if needed
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
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(
                                                    0xff7A7A7A), // Change this to your desired focused error border color
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.v),

                                  // country/region
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'COUNTRY / REGION *',
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 14.56,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                              height: screenwidth <= 360
                                                  ? 5.v
                                                  : 10.v),
                                          Text(
                                            'Jordan',
                                            // textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 14.56,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.v),

                                  // street
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'STREET ADDRESS *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14.56,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 10.v),
                                      Container(
                                        height: screenwidth <= 360 ? 30 : 45,
                                        child: TextFormField(
                                          // initialValue: _street,
                                          style: TextStyle(color: Colors.grey),
                                          controller: _streetController,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            // labelText: 'Amman',
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
                                                width:
                                                    1.0, // Change the width if needed
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
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(
                                                    0xff7A7A7A), // Change this to your desired focused error border color
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your username';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.v),

                                  // town/city
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'TOWN / CITY *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14.56,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 10.v),
                                      Container(
                                        height: screenwidth <= 360 ? 30 : 45,
                                        child: TextFormField(
                                          // initialValue: _town,
                                          style: TextStyle(color: Colors.grey),
                                          controller: _townCityController,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            // labelText: 'Amman',
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
                                                width:
                                                    1.0, // Change the width if needed
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
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(
                                                    0xff7A7A7A), // Change this to your desired focused error border color
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your username';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.v),

                                  // STATE COUNTRY
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'STATE / COUNTRY *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14.56,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 8.v),
                                      Container(
                                        height: screenwidth <= 360 ? 30 : 45,
                                        child: TextFormField(
                                          controller: _stateCountryController,
                                          autofocus: false,
                                          style: TextStyle(color: Colors.grey),
                                          decoration: InputDecoration(
                                            // labelText: '+91 6367097548',
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
                                                width:
                                                    1.0, // Change the width if needed
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
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(
                                                    0xff7A7A7A), // Change this to your desired focused error border color
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.v),

                                  // POSTCODE
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'POSTCODE / ZIP *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14.56,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 10.v),
                                      Container(
                                        height: screenwidth <= 360 ? 30 : 45,
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.grey),
                                          controller: _postCodeController,
                                          autofocus: false,
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
                                                width:
                                                    1.0, // Change the width if needed
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
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(
                                                    0xff7A7A7A), // Change this to your desired focused error border color
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your username';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 27.v),
                                  CustomElevatedButton(
                                      text: "Save Address",
                                      onPressed: () {
                                        _update();
                                        print('Address Saved');
                                        //Navigator.push(context, MaterialPageRoute(builder: ((context) => OtpVerifyScreen())));
                                      }),
                                  SizedBox(height: 27.v),
                                ])))
                  ]))),
        ]));
  }
}
