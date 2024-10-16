import 'package:flutter/material.dart';
import 'package:project/screens/about.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/licenseplate.dart';
import 'package:project/screens/profilesscreen.dart';
import 'package:project/widget/mobile_grid_view.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({super.key});

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: MyMobileGridView(), // Your GridView widget
            ),
          ],
        ));
  }
}
