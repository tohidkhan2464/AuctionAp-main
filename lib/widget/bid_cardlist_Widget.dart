import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/screens/auctionfeepayment.dart';
import 'package:project/screens/itemdetail.dart';
import 'package:project/utils/getTimeFromDateAndTime.dart';
import 'package:project/utils/loadImageFromUrl.dart';
import 'package:project/utils/timer.dart';

class CustomBidCardListWidget extends StatefulWidget {
  final dynamic product;

  CustomBidCardListWidget({Key? key, required this.product});

  @override
  _CustomBidCardListWidgetState createState() =>
      _CustomBidCardListWidgetState();
}

class _CustomBidCardListWidgetState extends State<CustomBidCardListWidget> {
  late Future<ui.Image> _imageFuture;
  late String _status;
  late String extractedText;

  @override
  void initState() {
    super.initState();
    print("widget.product ${widget.product}");
    _status = widget.product['status'];
    _imageFuture = loadImageFromUrl(widget.product['image'] != false
        ? widget.product['image'][0]
        : 'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png');
    String htmlString = widget.product['status_a'];

    RegExp exp = RegExp(r'<span>(.*?)</span>');
    Match? match = exp.firstMatch(htmlString);

    if (match != null) {
      extractedText = match.group(1)!;
    } else {
      extractedText = "null";
    }
    // DateTime auctionEnd = DateTime.parse(widget.product['auction_end_three']);
    // DateTime now = DateTime.now();
    // if (now.isAfter(auctionEnd)) {
    //   isPaid = false;
    // } else {
    //   isPaid = true;
    // }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetail(
                    data: widget.product['product_id'],
                  )),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 126,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 18,
                          margin: EdgeInsets.only(top: 10, left: 10),
                          color: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            child: DateTime.parse(widget.product['auction_end'])
                                    .isAfter(DateTime.now())
                                ? TimerCountdown(
                                    format: CountDownTimerFormat
                                        .daysHoursMinutesSeconds,
                                    endTime: DateTime.parse(
                                        widget.product['auction_end']),
                                    daysDescription: "d",
                                    hoursDescription: "h",
                                    minutesDescription: "m",
                                    secondsDescription: "s",
                                    descriptionTextStyle: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                    timeTextStyle: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                    colonsTextStyle: TextStyle(
                                        fontSize: 0, color: Colors.white),
                                    spacerWidth: 1,
                                  )
                                : Text(
                                    getDate(widget.product['auction_end']),
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                  ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: screenWidth * .32,
                          child: FutureBuilder<ui.Image>(
                            future: _imageFuture,
                            builder: (BuildContext context,
                                AsyncSnapshot<ui.Image> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Icon(Icons.error);
                                } else {
                                  return RawImage(
                                    image: snapshot.data,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  );
                                }
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // title
                    Container(
                      width: screenWidth * .45,
                      margin: EdgeInsets.only(top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product['product_name'],
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Current Bid
                    Container(
                      width: screenWidth * .5,
                      margin: EdgeInsets.only(top: 5, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Current bid:",
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.product['currency'] +
                                " " +
                                widget.product['max_bid_value'],
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Your Bid
                    Container(
                      margin: EdgeInsets.only(top: 5, right: 10),
                      width: screenWidth * .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your bid:",
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.product['currency'] +
                                " " +
                                widget.product['last_bid_user'],
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Status of Bid
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      // height: screenHeight * .03,
                      width: screenWidth * .5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.transparent,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status : ' + _status,
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (widget.product['is_winner'] &&
                                widget.product['is_closed'] != false &&
                                extractedText != "Closed")
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AuctionFeePayment(
                                            order_id: widget.product['order_id']
                                                .toString(),
                                            fee: widget.product['last_bid_user']
                                                .toString(),
                                            auctionid: widget
                                                .product['product_id']
                                                .toString())),
                                  );
                                },
                                child: Container(
                                  height: 32,
                                  width: 70,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.black,
                                      border: Border.all(color: Colors.black)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Pay Now",
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (widget.product['is_closed'] == false)
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ItemDetail(
                                              data:
                                                  widget.product['product_id'],
                                            )),
                                  );
                                },
                                child: Container(
                                  height: 32,
                                  width: 70,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Color(0xffffffff),
                                      border: Border.all(color: Colors.black)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'View',
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
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
          Positioned(
            top: 15,
            right: 25,
            child: Container(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                widget.product['status'] == 'Closed'
                    ? widget.product['is_winner']
                        ? "assets/icon/trophy.svg"
                        : "assets/icon/ban.svg"
                    : "assets/icon/timer2.svg",
                height: 20,
                width: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
