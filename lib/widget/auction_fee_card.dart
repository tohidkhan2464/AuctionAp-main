import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/auctionfeepayment.dart';
import 'package:project/screens/orderDetails.dart';
import 'package:project/screens/transaction_screen.dart';
import 'package:project/utils/getTimeFromDateAndTime.dart';

class CustomAuctionCardListWidget extends StatefulWidget {
  final Map<String, dynamic> item;
  final String userId;
  CustomAuctionCardListWidget({
    Key? key,
    required this.item,
    required this.userId,
  }) : super(key: key);

  @override
  _CustomAuctionCardListWidgetState createState() =>
      _CustomAuctionCardListWidgetState();
}

class _CustomAuctionCardListWidgetState
    extends State<CustomAuctionCardListWidget> {
  late Future<ui.Image> _imageFuture;
  late String title;
  late String status;
  late String highestbidder;
  late String order_id;
  late String order_number;
  late String date;
  bool _isLoading = false;
  late String price;
  late String currentUserId;
  late Map<String, dynamic> orders_actions;

  @override
  void initState() {
    super.initState();
    print("fee item ${widget.item}");
    _imageFuture = loadImageFromUrl(widget.item['order_image'][0] ??
        'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png');
    title = widget.item['order_type'] ?? 'No Title';

    status = widget.item['order_status'] ?? 'No Status';
    highestbidder = (widget.item['highestbidder']) ?? '0';
    order_id = (widget.item['order_id']) ?? '0';
    order_number = (widget.item['order_number']) ?? '0';
    currentUserId = widget.userId.toString();
    date = widget.item['order_date'] ?? 'No Date';
    price = widget.item['order_price'].split('.')[0] ?? 'No Price';
  }

  Future<ui.Image> loadImageFromUrl(String url) async {
    final Uri resolved = Uri.base.resolve(url);
    final ByteData data = await NetworkAssetBundle(resolved).load("");
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  void showPaymentPopup(BuildContext context, String title, String text,
      bool isRefund, String buttonText, productId, fee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  margin: EdgeInsets.only(bottom: 20),
                  height: 32,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      if (isRefund) {
                        ApiService().order_refund(productId).then((success) {
                          print("order refund $success");
                          int count = 0;

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Transactions(),
                            ),
                            (Route<dynamic> route) {
                              return count++ == 2;
                            },
                          );
                          setState(() {
                            _isLoading = false;
                          });
                        });
                      } else {
                        var auction = productId;
                        var price = fee;
                        int count = 0;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuctionFeePayment(
                                  order_id: auction,
                                  fee: price,
                                  auctionid: order_id)),
                        );
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text(
                      _isLoading ? "Loading..." : buttonText,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 118,
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
                    Container(
                      width: screenWidth * .32,
                      height: 65,
                      child: FutureBuilder<ui.Image>(
                        future: _imageFuture,
                        builder: (BuildContext context,
                            AsyncSnapshot<ui.Image> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Icon(Icons.error);
                            } else {
                              return Center(
                                child: RawImage(
                                  image: snapshot.data,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  // height: 70,
                                ),
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
                SizedBox(width: 10),
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
                      margin: EdgeInsets.only(top: 5),
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
                            'Fee: ',
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
                      margin: EdgeInsets.only(top: 5),
                      color: Colors.transparent,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (status == "Pending payment")
                              InkWell(
                                onTap: () {
                                  showPaymentPopup(
                                      context,
                                      "PAY THE FEE AND START NOW TO BID!",
                                      "This is the fee of an auction. \n All participants must pay a fee of JOD $price to place bids",
                                      false,
                                      "Pay Now",
                                      widget.item['order_id'].toString(),
                                      price.toString());
                                },
                                child: Container(
                                  // margin: EdgeInsets.only(top: 5),
                                  height: 32,
                                  width: screenWidth * .5,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Color(0xff000000),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Pay",
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            if ((status == "processing" ||
                                    status == "Completed") &&
                                currentUserId.toString() !=
                                    highestbidder.toString() &&
                                DateTime.now().isAfter(DateTime.parse(
                                    widget.item['auction_date'])))
                              InkWell(
                                onTap: () {
                                  showPaymentPopup(
                                      context,
                                      "Are you sure to get the refund!",
                                      "This auction fee of JOD $price was previously paid to participate in the bidding.\nDo you wish to proceed with the refund request for this amount?",
                                      true,
                                      "Request Refund",
                                      widget.item['order_id'].toString(),
                                      price.toString());
                                },
                                child: Container(
                                  height: 32,
                                  width: screenWidth * .5,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Color(0xff000000),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Refund",
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            if (status == 'Refund Request')
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 32,
                                  width: screenWidth * .5,
                                  child: Center(
                                    child: Text(
                                      "Refund Requested",
                                      style: TextStyle(
                                          // decoration: TextDecoration.underline,
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            if ((status != "processing" ||
                                    status != "Completed") &&
                                status != 'Refund Request' &&
                                status != "Pending payment" &&
                                currentUserId.toString() ==
                                    highestbidder.toString())
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
                                  height: 32,
                                  width: screenWidth * .5,
                                  child: Center(
                                    child: Text(
                                      "View",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
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
        ],
      ),
    );
  }
}
