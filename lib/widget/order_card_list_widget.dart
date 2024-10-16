import 'package:flutter/material.dart';

class CustomOrderCardListWidget extends StatefulWidget {
  // final String? title;
  // final String? price;

  CustomOrderCardListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CustomOrderCardListWidgetState createState() =>
      _CustomOrderCardListWidgetState();
}

class _CustomOrderCardListWidgetState extends State<CustomOrderCardListWidget> {
  String _status = 'Started';
  // final List<String> _statusType = ["Pending Payemt", "Refunded", "Completed"];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 90,
              width: screenWidth * .9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 18,
                        width: 80,
                        // alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 10),
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 8),
                          child: Text(
                            'June 1, 2024',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: screenWidth * .28,
                        child: Image.asset(
                          'assets/image/plate.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 45,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Status
                      Container(
                        width: screenWidth * .45,
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _status,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ]),
                      ),

                      // total
                      Container(
                        width: screenWidth * .45,
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total:",
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "JOD 999 for 1 item",
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 8.0, bottom: 5),
                        height: 0.6,
                        width: screenWidth * .45,
                        color: Colors.grey,
                      ),

                      // Actions
                      Container(
                        // margin: EdgeInsets.only(top: 5),
                        height: screenHeight * .05,
                        width: screenWidth * .45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.transparent,
                        ),
                        // height: 26,

                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_status == "Pending Payemt")
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: screenHeight * .03,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Pay",
                                            style: TextStyle(
                                              fontFamily: 'Work Sans',
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: screenHeight * .03,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "View",
                                          style: TextStyle(
                                            fontFamily: 'Work Sans',
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (_status == "Pending Payemt")
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: screenHeight * .03,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Cancel",
                                            style: TextStyle(
                                              fontFamily: 'Work Sans',
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
