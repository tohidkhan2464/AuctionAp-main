import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:project/screens/itemdetail.dart';
import 'package:project/utils/loadImageFromUrl.dart';
import 'package:project/utils/timer.dart';

class CustomCardWidget extends StatefulWidget {
  final dynamic product;
  final String? title;
  final String? price;

  CustomCardWidget({this.title, this.price, required this.product});

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  late Future<ui.Image> _imageFuture;

  List<dynamic> product = [];

  @override
  void initState() {
    super.initState();
    // print("widget ${widget.product}");
    _imageFuture = loadImageFromUrl(widget.product['image'] != false
        ? widget.product['image'][0]
        : 'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetail(
                    data: widget.product['ID'],
                  )),
        );
        //}
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 160,
        width: 147,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 16,
              margin: const EdgeInsets.only(top: 10, left: 9),
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                child: TimerCountdown(
                  format: CountDownTimerFormat.daysHoursMinutesSeconds,
                  endTime: DateTime.parse(widget.product['auction_end_new']),
                  daysDescription: "d",
                  hoursDescription: "h",
                  minutesDescription: "m",
                  secondsDescription: "s",
                  descriptionTextStyle:
                      const TextStyle(fontSize: 8, color: Colors.white),
                  timeTextStyle:
                      const TextStyle(fontSize: 8, color: Colors.white),
                  colonsTextStyle:
                      const TextStyle(fontSize: 0, color: Colors.white),
                  spacerWidth: 1,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: FutureBuilder<ui.Image>(
                  future: widget.product['image'] != false
                      ? loadImageFromUrl(widget.product['image'][0])
                      : loadImageFromUrl(
                          'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png'),
                  builder:
                      (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Container(
                          height: 45,
                          width: double.infinity,
                          child: const Icon(Icons.error),
                        );
                      } else {
                        return RawImage(
                          image: snapshot.data,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: 45,
                        );
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Text(
                  widget.product["post_title"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Work Sans',
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "JOD " + widget.product['current_price'].toString(),
                style: const TextStyle(
                  fontFamily: 'Work Sans',
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                width: 124,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: const Color(0xff181816),
                ),
                height: 32,
                child: const Center(
                  child: Text(
                    'Bid Now',
                    style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
