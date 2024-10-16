import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:project/utils/loadImageFromUrl.dart';
// import 'package:project/utils/loadImageFromUrl/timer.dart';

class CustomCartCardListWidget extends StatefulWidget {
  final String? status;
  final dynamic product;

  CustomCartCardListWidget({Key? key, this.status, required this.product});

  @override
  _CustomCartCardListWidgetState createState() =>
      _CustomCartCardListWidgetState();
}

class _CustomCartCardListWidgetState extends State<CustomCartCardListWidget> {
  late Future<ui.Image> _imageFuture;
  late var _counter;
  @override
  void initState() {
    super.initState();
    _counter = widget.product['quantity'] ?? 1;
    _imageFuture = loadImageFromUrl(widget.product['product_image'][0] ??
        "https://app.raqamak.vip/wp-content/uploads/2024/04/5-3.png");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ItemDetail(data: widget.product),
        //   ),
        // );
      },
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 110,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * .32,
                        child:
                            // Image.asset(
                            //   'assets/image/plate.png',
                            //   fit: BoxFit.cover,
                            //   width: double.infinity,
                            //   // height: 45,
                            // ),
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
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      Container(
                        width: screenWidth * .5,
                        margin: EdgeInsets.only(top: 5, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price :",
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "JOD " +
                                  ((widget.product['line_total'])).toString(),
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: screenWidth * .5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.transparent,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: screenWidth * .25,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(width: 10),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (_counter > 1) {
                                              _counter -= 1;
                                            } else {
                                              _counter = 1;
                                            }
                                          });
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: _counter == 1
                                              ? Colors.grey
                                              : Colors.black,
                                          size: 15,
                                        )),
                                    SizedBox(width: 10),
                                    Text(
                                      '$_counter',
                                      style: TextStyle(
                                        fontFamily: 'Work Sans',
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            _counter += 1;
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: _counter == 100
                                              ? Colors.grey
                                              : Colors.black,
                                          size: 15,
                                        )),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                              Text(
                                'Remove',
                                style: TextStyle(
                                  fontFamily: 'Work Sans',
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
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
