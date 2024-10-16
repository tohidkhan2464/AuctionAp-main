import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/widget/bid_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xfff5f5f5),
        appBar: AppBar(
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
          automaticallyImplyLeading: true,
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
        body: ListView(children: [
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
                  "From your account dashboard you can view your recent orders, manage your shopping and billing addresses, and edit your password and account details.",
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

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: Text(
                    'RECENT 3 BIDS',
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
                            builder: ((context) => HomeScreen(
                                  index: 3,
                                ))));
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 2),
                        child: Text(
                          'VIEW ALL',
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
                ),
              ],
            ),
          ),
          // bid card
          Column(
            children: [BidCard()],
          ),
        ]));
  }
}
