import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/itemdetail.dart';
import 'package:project/utils/loadImageFromUrl.dart';
import 'package:project/utils/timer.dart';

class CardListWidget extends StatefulWidget {
  final dynamic product;
  final String? title;
  final String? price;
  final int? id;
  CardListWidget({this.title, this.price, this.product, this.id});
  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  bool isFavorite = false;
  late Future<ui.Image> _imageFuture;
  final ApiService _apiService = ApiService();
  List<dynamic> product = [];

  @override
  void initState() {
    super.initState();
    print("tags ${widget.product['tags']}");
    _imageFuture = fetchImage(widget.product['image'] != false
        ? widget.product['image'][0]
        : 'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetail(
                    data: widget.product['ID'],
                  )),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
            height: 126,
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
                          child:
                              DateTime.parse(widget.product['auction_end_new'])
                                      .isBefore(DateTime.now())
                                  ? Text(
                                      "Ended",
                                      style: TextStyle(
                                          fontSize: 8,
                                          fontFamily: "Work Sans",
                                          color: Colors.white),
                                    )
                                  : TimerCountdown(
                                      format: CountDownTimerFormat
                                          .daysHoursMinutesSeconds,
                                      endTime: DateTime.parse(
                                          widget.product['auction_end_new']),
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
                                    )),
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: screenWidth * .35,
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
                    SizedBox(height: 5),
                    Text(
                      widget.product["post_title"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
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
                      height: 1,
                      width: screenWidth * .46,
                      color: Color(0xfff1f1f1),
                    ),
                    Container(
                      width: screenWidth * .46,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Current Bid",
                            style: TextStyle(
                                fontFamily: 'Work Sans',
                                color: Colors.black54,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.product['currency'].toString() +
                                " " +
                                widget.product['current_price'].toString(),
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
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      height: 32,
                      width: screenWidth * .46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Color(0xff181816),
                      ),
                      child: Center(
                        child: Text(
                          'Place a bid',
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(widget.product['watchlist']
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: widget.product['watchlist'] ? Colors.black : Colors.grey,
              onPressed: () async {
                ApiService.getdata('ID').then((userid) {
                  print('current user id' + userid);
                  final body = jsonEncode({
                    "user_id": userid.toString(),
                    "auction": widget.product['ID'].toString(),
                  });

                  _apiService.add_to_watchlists(body).then((success) {
                    if (jsonDecode(success)['message'] ==
                        'Added to Watchlist successfully') {
                      setState(() {
                        isFavorite = !isFavorite;
                        widget.product['watchlist'] =
                            !widget.product['watchlist'];
                      });
                      const GetSnackBar(
                        message: 'Item added to watchlist.',
                        backgroundColor: Colors.grey,
                        duration: Duration(seconds: 2),
                        snackPosition: SnackPosition.TOP,
                      ).show();
                    } else if (jsonDecode(success)['message'] ==
                        'Removed from Watchlist successfully') {
                      setState(() {
                        isFavorite = !isFavorite;
                        widget.product['watchlist'] =
                            !widget.product['watchlist'];
                      });
                      const GetSnackBar(
                        message: 'Item removed from watchlist.',
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
                    }
                  });
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
