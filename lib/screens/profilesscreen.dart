import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/about.dart';
import 'package:project/screens/account_details_screen.dart';
import 'package:project/screens/dashboardscreen.dart';
import 'package:project/screens/favourite.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/licenseplate.dart';
import 'package:project/screens/mobilenumber.dart';
import 'package:project/screens/transaction_screen.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final picker = ImagePicker();
  bool _isLoading = false;
  String _image = '';

  @override
  void initState() {
    _getUserProfilePic();
    super.initState();
  }

  void _getUserProfilePic() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userid = await ApiService.getdata('ID');

      ApiService().fetchProfilePhoto(userid.toString()).then((value) {
        print("fetchProfilePhoto ${value}");

        if (mounted && value['url'] != '') {
          setState(() {
            _image = value['url'];
            _isLoading = false;
          });
        } else {
          print('No photo');
          setState(() {
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      print('Failed to load photo: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xfff5f5f5),
        endDrawer: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Drawer(
            backgroundColor: const Color(0xff181816),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(
                  height: 50,
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/icon/home2.png',
                    width: 30,
                    color: Colors.grey,
                  ),
                  title: const Text(
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
                  title: const Text(
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
                            builder: ((context) => const LicencePlate())));
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/icon/mobile.png',
                    width: 30,
                  ),
                  title: const Text(
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
                            builder: ((context) => const MobileNumber())));
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/icon/about.png',
                    width: 30,
                  ),
                  title: const Text(
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
                            builder: ((context) => const AboutScreen())));
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/icon/profile.png',
                    width: 30,
                  ),
                  title: const Text(
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
                            builder: ((context) => const ProfileScreen())));
                  },
                ),
              ],
            ),
          ),
        ),
        body: ListView(children: [
          const SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Center(
                child: Container(
                    height: 120,
                    width: 120,
                    padding: EdgeInsets.all(_image == "" ? 25 : 0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : _image == ""
                            ? SvgPicture.asset("assets/icon/user2.svg")
                            : ClipOval(
                                child: Image.network(
                                  _image,
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: 120,
                                  frameBuilder: (BuildContext context,
                                      Widget child,
                                      int? frame,
                                      bool? wasSynchronouslyLoaded) {
                                    return child;
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )),
              ),
              Positioned(
                bottom: 5,
                left: 230,
                child: InkWell(
                  onTap: () {
                    _showPicker(context: context);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: _image == ""
                        ? Image.asset(
                            "assets/icon/camera.png",
                            height: 22,
                            width: 22,
                            color: Colors.black,
                          )
                        : const Icon(Icons.edit, color: Colors.black, size: 20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "User",
                style: TextStyle(
                    fontFamily: "Work Sans", fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const DashboardScreen())));
                },
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    // width: screenWidth * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            // Image.asset("assets/icon/dashboard.png"),
                            Container(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(
                                "assets/icon/dashboard2.svg",
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Dashboard",
                              style: TextStyle(
                                fontFamily: 'Word Sans',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ))),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => HomeScreen(
                                index: 3,
                              ))));
                },
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    // width: screenWidth * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(
                                "assets/icon/basket2.svg",
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "My Bids",
                              style: TextStyle(
                                fontFamily: 'Word Sans',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ))),
              ),
              /*  InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => MyCartScreen())));
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    // width: screenWidth * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white),
                    child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                            // Container(
                            //   height: 20,
                            //   width: 20,
                            //   child: SvgPicture.asset(
                            //     "assets/icon/user2.svg",
                            //     // semanticsLabel: 'My SVG Image',
                            //     height: 20,
                            //     width: 20,
                            //   ),
                            // ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "My Cart",
                              style: TextStyle(
                                fontFamily: 'Word Sans',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ))),
              ), */
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const Transactions())));
                },
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    // width: screenWidth * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.money,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Transactions",
                              style: TextStyle(
                                fontFamily: 'Word Sans',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ))),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => FavoritesScreen())));
                },
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    // width: screenWidth * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Watchlist",
                              style: TextStyle(
                                fontFamily: 'Word Sans',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ))),
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: ((context) => AddressScreen())));
              //   },
              //   child: Container(
              //       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              //       // width: screenWidth * 0.9,
              //       height: 50,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(0),
              //           color: Colors.white),
              //       child: Container(
              //           margin: EdgeInsets.only(left: 20),
              //           child: Row(
              //             children: [
              //               // Image.asset(
              //               //   "assets/icon/home3.png",
              //               //   height: 20,
              //               //   width: 20,
              //               // ),
              //               Container(
              //                 height: 20,
              //                 width: 20,
              //                 child: SvgPicture.asset(
              //                   "assets/icon/home2.svg",
              //                   // semanticsLabel: 'My SVG Image',
              //                   height: 20,
              //                   width: 20,
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 20,
              //               ),
              //               Text(
              //                 "Addresses",
              //                 style: TextStyle(
              //                   fontFamily: 'Word Sans',
              //                   fontSize: 18,
              //                 ),
              //               ),
              //             ],
              //           ))),
              // ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              const AccountDetaialScreen())));
                },
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    // width: screenWidth * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            // Icon(
                            //   Icons.person,
                            //   color: Colors.black,
                            //   size: 20,
                            // ),
                            Container(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(
                                "assets/icon/user2.svg",
                                // semanticsLabel: 'My SVG Image',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Account Details",
                              style: TextStyle(
                                fontFamily: 'Word Sans',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ))),
              ),
              InkWell(
                onTap: () {
                  ApiService.getdata('ID').then((userid) {
                    print("user id in logout $userid");
                    if (userid != null) {
                      ApiService.removeSessionData('is_loggedin');
                      ApiService.removeSessionData('userdata');
                      ApiService.removeSessionData('token');
                      ApiService.removeSessionData('ID');
                    }
                  });
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: ((context) => LoginScreen())));
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    // width: screenWidth * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: const Icon(
                                Icons.logout,
                                color: Colors.black,
                                // size: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Log Out",
                              style: TextStyle(
                                fontFamily: 'Word Sans',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ))),
              ),
            ],
          )
        ]));
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text(
                  'Photo Library',
                  style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 16,
                      color: Colors.black),
                ),
                onTap: () {
                  getImage(ImageSource.gallery);
                  print('_showPicker gallery');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text(
                  'Camera',
                  style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 16,
                      color: Colors.black),
                ),
                onTap: () {
                  getImage(ImageSource.camera);
                  print('_showPicker camera');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  upload(File imageFile) async {
    print(
        "image name ${imageFile.path}  ${imageFile.parent}  ${imageFile.isAbsolute}  ${imageFile.uri}");
    try {
      var headers = {
        "Authorization":
            "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      };
      var userId = await ApiService.getdata("ID");
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://app.raqamak.vip/wp-json/app/v1/upload-profile-pic'));
      request.fields['user_id'] = userId;
      request.files.add(await http.MultipartFile.fromBytes(
          'user_pic', File(imageFile.path).readAsBytesSync(),
          filename: imageFile.path));
      request.headers.addAll(headers);

      var response = await request.send();
      var res = (await response.stream.bytesToString());
      if (response.statusCode == 200) {
        return (jsonDecode(res));
      } else {
        throw Exception('Failed to fetch product');
      }
    } catch (e) {
      print('Failed to load photo: $e');
    }
  }

  Future getImage(source) async {
    print("getImage");
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });
      print('image selected');
      var body = await upload(File(pickedFile.path));
      print('image selected $body');
      if (body['url'] != '') {
        setState(() {
          _image = body['url'];
          _isLoading = false;
        });
        const GetSnackBar(
          message: 'Profile photo updated successfully.',
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
        ).show();
      } else {
        const GetSnackBar(
          message: 'Something went wrong. Please try again.',
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
        ).show();
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('no image selected');
      const GetSnackBar(
        message: 'No Image selected.',
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      ).show();
      setState(() {
        _isLoading = false;
      });
    }
  }
}
