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
import 'package:project/widget/custom_text_field.dart';

// ignore_for_file: must_be_immutable
class EditBillingInfoScreen extends StatefulWidget {
  const EditBillingInfoScreen({Key? key}) : super(key: key);

  @override
  _EditBillingInfoScreenState createState() => _EditBillingInfoScreenState();
}

class _EditBillingInfoScreenState extends State<EditBillingInfoScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _townCityController = TextEditingController();
  final _phoneController = TextEditingController();

  // final _firstName = "";
  // final _lastName = "";
  // final _town = "";
  // final _mobile = "";
  // final _email = "";

  // final ApiService _apiService = ApiService();
  void _update() async {
    try {
      // final response = await _apiService.signup({
      //   "email": _emailController.text,
      //   "first_name": _firstNameController.text,
      //   // "password": _passwordController.text,
      //   "last_name": _lastNameController.text,
      //   "phone": _phoneController.text,
      //   "town": _townCityController.text,
      //   "country": "Jordan",
      //   // "social": {"instagram": _instagramController.text},
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
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
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
                  // height: mediaQueryData.size.height,
                  width: double.maxFinite,
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20.v),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("BILLING ADDRESS",
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400))),
                                  SizedBox(height: 20),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // FIRST NAME
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'First Name *',
                                              style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(height: 10.v),
                                            Container(
                                              width:
                                                  mediaQueryData.orientation ==
                                                          Orientation.portrait
                                                      ? screenwidth * .4
                                                      : screenwidth * .45,
                                              child: CustomTextFormField(
                                                  controller:
                                                      _firstNameController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter your First Name';
                                                    }
                                                    return null;
                                                  },
                                                  autofocus: false,
                                                  fillColor: Color(0xffd9d9d9),
                                                  textStyle: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontSize: 14.56,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  filled: true,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  textInputType:
                                                      TextInputType.text,
                                                  prefixConstraints:
                                                      BoxConstraints(
                                                          maxHeight: 53)),
                                            )
                                          ],
                                        ),
                                      ),

                                      // LAST NAME
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Last Name *',
                                              style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(height: 10.v),
                                            Container(
                                              width:
                                                  mediaQueryData.orientation ==
                                                          Orientation.portrait
                                                      ? screenwidth * .4
                                                      : screenwidth * .45,
                                              child: CustomTextFormField(
                                                  controller:
                                                      _lastNameController,
                                                  autofocus: false,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter your Last Name';
                                                    }
                                                    return null;
                                                  },
                                                  textStyle: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontSize: 14.56,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  fillColor: Color(0xffd9d9d9),
                                                  filled: true,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  textInputType:
                                                      TextInputType.text,
                                                  prefixConstraints:
                                                      BoxConstraints(
                                                          maxHeight: 53.v)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // country/region
                                  Container(
                                    margin:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? EdgeInsets.only(top: 20)
                                            : EdgeInsets.only(top: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Country / Region *',
                                              style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: screenwidth <= 360
                                                  ? 5.v
                                                  : 10.v,
                                            ),
                                            Text(
                                              'Jordan',
                                              style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  // town/city
                                  Container(
                                    margin:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? EdgeInsets.only(top: 20)
                                            : EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Town / City *',
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14.56,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: 10.v),
                                        Container(
                                          child: CustomTextFormField(
                                              controller: _townCityController,
                                              autofocus: false,
                                              fillColor: Color(0xffd9d9d9),
                                              filled: true,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your Town / City.';
                                                }
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.done,
                                              textStyle: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w400),
                                              textInputType: TextInputType.text,
                                              prefixConstraints: BoxConstraints(
                                                  maxHeight: 53.v)),
                                        )
                                      ],
                                    ),
                                  ),

                                  // phone Number
                                  Container(
                                    margin:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? EdgeInsets.only(top: 20)
                                            : EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone *',
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14.56,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: 10.v),
                                        Container(
                                          child: CustomTextFormField(
                                              controller: _phoneController,
                                              autofocus: false,
                                              fillColor: Color(0xffd9d9d9),
                                              filled: true,
                                              textInputAction:
                                                  TextInputAction.done,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your Phone Number.';
                                                }
                                                return null;
                                              },
                                              textStyle: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w400),
                                              textInputType: TextInputType.text,
                                              prefixConstraints: BoxConstraints(
                                                  maxHeight: 53.v)),
                                        )
                                      ],
                                    ),
                                  ),

                                  // Email address
                                  Container(
                                    margin:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? EdgeInsets.only(top: 20)
                                            : EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email Address *',
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14.56,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: 10.v),
                                        Container(
                                          child: CustomTextFormField(
                                              controller: _emailController,
                                              fillColor: Color(0xffd9d9d9),
                                              filled: true,
                                              textInputAction:
                                                  TextInputAction.done,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your Email Address.';
                                                }
                                                return null;
                                              },
                                              textStyle: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w400),
                                              autofocus: false,
                                              textInputType: TextInputType.text,
                                              prefixConstraints: BoxConstraints(
                                                  maxHeight: 53.v)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 27.v),

                                  Center(
                                    child: Container(
                                        child: InkWell(
                                            onTap: () {
                                              _update();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 0, top: 30),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(00),
                                                  color: Colors.black),
                                              child: Center(
                                                child: Text(
                                                  "Save Address",
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ))),
                                  ),
                                  SizedBox(height: 27.v),
                                ])))
                  ]))),
        ]));
  }
}
