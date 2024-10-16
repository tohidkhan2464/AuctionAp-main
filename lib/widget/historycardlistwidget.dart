import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/itemdetail.dart';
import 'package:project/utils/timer.dart';

class HistoryCardListWidget extends StatefulWidget {
  final dynamic product;
  final String? title;
  final String? price;
  HistoryCardListWidget({this.title, this.price, required this.product});
  Timer? timer;
  @override
  State<HistoryCardListWidget> createState() => _HistoryCardListWidgetState();
}

class _HistoryCardListWidgetState extends State<HistoryCardListWidget> {
  late Future<ui.Image> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = loadImageFromUrl(widget.product['featured_src']);
  }

  Future<ui.Image> loadImageFromUrl(String url) async {
    final Uri resolved = Uri.base.resolve(url);
    final ByteData data = await NetworkAssetBundle(resolved).load("");
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
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
              data: widget.product,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
            height: 118,
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
                      height: 18,
                      margin: EdgeInsets.only(top: 10, left: 10),
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        child: TimerCountdown(
                          format: CountDownTimerFormat.daysHoursMinutesSeconds,
                          endTime: DateTime.parse(widget.product['updated_at']),
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
                      height: 45,
                      child:
                          // Text(
                          //   widget.product["title"],
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
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 45,
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
                        widget.product["title"],
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Auction with Automatic bid',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      width: screenWidth * .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Current Bid",
                            style: TextStyle(
                                fontFamily: 'Work Sans',
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "JOD " + widget.product['price'],
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
                      width: screenWidth * .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your Bid",
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            "JOD " + widget.product['sale_price'],
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
                      margin: const EdgeInsets.only(top: 5.0),
                      height: 0.6,
                      width: screenWidth * .5,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      height: screenHeight * .03,
                      width: screenWidth * .5,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(0),
                      //   color: Color(0xff181816),
                      // ),
                      child: Center(
                        child: Text(
                          'Allocated to You',
                          style: TextStyle(color: Colors.black, fontSize: 12),
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
