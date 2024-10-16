import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:project/screens/itemdetail.dart';
import 'package:project/utils/getTimeFromDateAndTime.dart';
import 'package:project/utils/loadImageFromUrl.dart';
import 'package:project/utils/timer.dart';

List<Map<String, dynamic>> favorites = [];

class RelatedProducts extends StatefulWidget {
  final dynamic product;
  final String? title;
  final String? price;
  final int? id;
  RelatedProducts({this.title, this.price, this.product, this.id});

  @override
  State<RelatedProducts> createState() => _RelatedProductsState();
}

class _RelatedProductsState extends State<RelatedProducts> {
  bool isFavorite = false;
  late Future<ui.Image> _imageFuture;

  @override
  void initState() {
    super.initState();
    // _imageFuture = loadImageFromUrl(widget.product['image'] != false
    //     ? widget.product['image'][0]
    //     : 'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png');
    _imageFuture = loadImageFromUrl(
        'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png');
  }

  @override
  Widget build(BuildContext context) {
    var time = getTimeFromDateShort(widget.product['auction_date']);
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetail(data: widget.product),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, right: 0),
            padding: EdgeInsets.only(bottom: 10),
            height: 128,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      margin: EdgeInsets.only(top: 10, left: 10),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.grey,
                      child: Center(
                        child: TimerCountdown(
                          format: CountDownTimerFormat.daysHoursMinutesSeconds,
                          endTime:
                              DateTime.parse(widget.product['auction_date']),
                          daysDescription: "d",
                          hoursDescription: "h",
                          minutesDescription: "m",
                          secondsDescription: "s",
                          descriptionTextStyle:
                              TextStyle(fontSize: 8, color: Colors.white),
                          timeTextStyle:
                              TextStyle(fontSize: 8, color: Colors.white),
                          colonsTextStyle:
                              TextStyle(fontSize: 0, color: Colors.white),
                          spacerWidth: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: screenWidth * .32,
                      height: 70,
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
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: 70,
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 2),
                      child: Text(
                        widget.product["product_name"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Auction with Automatic bid',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8.0, bottom: 5),
                      height: 0.6,
                      width: screenWidth * .5,
                      color: Colors.grey,
                    ),
                    Container(
                      width: screenWidth * .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Current bid:",
                            style: TextStyle(
                                fontFamily: 'Work Sans',
                                color: Colors.black54,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "JOD " + widget.product['current_bid'].toString(),
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 24,
                      width: screenWidth * .5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Color(0xff181816),
                      ),
                      child: Center(
                        child: Text(
                          'Place a Bid',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
