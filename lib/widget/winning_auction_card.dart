import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/auctionfeepayment.dart';
import 'package:project/screens/orderDetails.dart';
import 'package:project/utils/getTimeFromDateAndTime.dart';

class CustomWinningCardListWidget extends StatefulWidget {
  final Map<String, dynamic> item;
  final String userId;
  CustomWinningCardListWidget({
    Key? key,
    required this.item,
    required this.userId,
  }) : super(key: key);

  @override
  _CustomWinningCardListWidgetState createState() =>
      _CustomWinningCardListWidgetState();
}

class _CustomWinningCardListWidgetState
    extends State<CustomWinningCardListWidget> {
  late Future<ui.Image> _imageFuture;
  late String title;
  late String order_id;
  late String order_number;
  late String status;
  late String date;
  late String price;

  List<dynamic> product = [];

  @override
  void initState() {
    super.initState();
    print("winnnig auction ${widget.item}");
    _imageFuture = loadImageFromUrl(widget.item['order_image'] == false
        ? 'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png'
        : widget.item['order_image'][0]);
    title = widget.item['order_type'] ?? 'No Title';
    status = widget.item['order_status'] ?? 'No Status';
    order_id = (widget.item['order_id']) ?? '0';
    order_number = (widget.item['order_number']) ?? '0';
    date = widget.item['order_date'] ?? 'No Date';
    price = widget.item['order_price'] ?? 'No Price';
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
              builder: (context) => OrderDetails(
                    data: order_id,
                  )),
        );
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
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
                      height: 18,
                      margin: EdgeInsets.only(top: 10),
                      color: Colors.grey,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            getDate(date),
                            style: TextStyle(fontSize: 8, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: screenWidth * .32,
                      // height: 45,
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
                                // height: 45,
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
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        order_number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Status
                    Container(
                      width: screenWidth * .5,
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              status,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                          ]),
                    ),

                    // total
                    Container(
                      width: screenWidth * .5,
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: ',
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            price + " JOD",
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Actions
                    Container(
                        width: screenWidth * .5,
                        child: Center(
                          child: Row(children: [
                            if (status == "Pending payment")
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AuctionFeePayment(
                                            order_id: widget.item['order_id']
                                                .toString(),
                                            fee: price.toString(),
                                            auctionid: widget.item['order_id']
                                                .toString())),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 5),
                                  height: 32,
                                  width: screenWidth * .5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: Color(0xff181816),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Pay",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Work Sans",
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            if (status != "Pending payment")
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderDetails(
                                              data: order_id,
                                            )),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 5),
                                  height: 32,
                                  width: screenWidth * .5 - 5,
                                  child: Center(
                                    child: Text(
                                      "View",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Work Sans",
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                          ]),
                        )),
                  ],
                ),
              ],
            ),
          ),
          /* Positioned(
            top: 15,
            right: 20,
            child: Container(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                "assets/icon/trophy.svg",
              ),
            ),
          ), */
        ],
      ),
    );
  }
}
