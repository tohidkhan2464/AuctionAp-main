import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/itemdetail.dart';
import 'package:project/utils/loadImageFromUrl.dart';
import 'package:project/utils/timer.dart';

class FavCardListWidget extends StatefulWidget {
  final dynamic product;
  final String? title;
  final String? price;
  final int? id;
  FavCardListWidget({this.title, this.price, this.product, this.id});
  // Timer? timer;
  @override
  State<FavCardListWidget> createState() => _FavCardListWidgetState();
}

class _FavCardListWidgetState extends State<FavCardListWidget> {
  bool isFavorite = false;
  late Future<ui.Image> _imageFuture;
  final ApiService _apiService = ApiService();
  List<dynamic> product = [];
  Future<List<dynamic>> _getProduct(int id) async {
    try {
      final userid = await ApiService.getdata('ID');
      final response = await _apiService.getProductdetailsnew(
          id.toString(), userid.toString());
      product = response;
      setState(() {});
      // print('_products response : $product');
      return response;
    } catch (e) {
      // print('_products failed : $e');
      throw Exception('Failed to fetch product_id');
    }
  }

  @override
  void initState() {
    super.initState();
    //print("favorites ${favorites}");

    print("favorites ${widget.product}");

    _imageFuture = fetchImage(widget.product['image'] != false
        ? widget.product['image'][0]
        : 'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetail(
                    data: widget.product['product'],
                  )),
        );
        //}
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
                      child:
                          //  Text(
                          //   widget.product["post_title"],
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //       fontSize: 16,
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.bold),
                          // )

                          FutureBuilder<ui.Image>(
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
                            widget.product['currency'] +
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
          // Positioned(
          //   top: 5,
          //   right: 5,
          //   child: IconButton(
          //     icon: Icon(Icons.favorite),
          //     color: Colors.black,
          //     onPressed: () {},
          //   ),
          // ),
        ],
      ),
    );
  }
}
