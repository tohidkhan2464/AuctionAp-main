import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/auth/api_service.dart';
import 'package:project/screens/bidingpg.dart';
import 'package:project/screens/checkoutbid.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/popup.dart';
import 'package:project/utils/getTimeFromDateAndTime.dart';
import 'package:project/utils/timer.dart';

class ItemDetail extends StatefulWidget {
  final dynamic data;
  const ItemDetail({required this.data});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  late Future<ui.Image> _imageFuture;
  bool isFavorite = false;
  late bool _is_auction_fee;
  late bool reserveprice;
  late bool is_fee_paid;
  late bool _is_buy_now;
  late int _counter;
  late String _currency;
  late String stock_status = 'instock';
  late int _price;
  late int _increment;
  late var _auction_fee;
  late var _buy_now;
  var bidders = [];
  var maxBidUser;
  var maxBidUserEmail;
  var currentUser;
  var title = '';
  var relatedProducts = [];
  var allData = [];
  bool _isLoading = false;
  bool _isLoadingButton = false;
  Popup popup = Popup();

  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showPaymentPopup(BuildContext context, String title, String text,
      bool IsFee, String buttonText, productId, fee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: IntrinsicHeight(
            child: Center(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isLoadingButton = false;
                        });
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
                    height: 32,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        var auction = productId;
                        var price = fee;
                        if (IsFee) {
                          int count = 0;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BiddingPage(auction: auction, fee: price)),
                            (Route<dynamic> route) {
                              return count++ == 2;
                            },
                          );
                        } else {
                          int count = 0;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => checkoutbidpg(
                                    auction: auction, price: price)),
                            (Route<dynamic> route) {
                              return count++ == 2;
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<ui.Image> fetchImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      return frameInfo.image;
    } else {
      throw Exception('Failed to load image');
    }
  }

  final ApiService _apiService = ApiService();
  void _getProducts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userid = await ApiService.getdata('ID');

      ApiService()
          .getProductdetailsnew(widget.data.toString(), userid.toString())
          .then((value) {
        print(value);
        if (mounted) {
          setState(() {
            allData = value;
            title = value[0]['post_title'];
            _counter = value[0]["current_price"];
            _price = value[0]["current_price"];
            _currency = value[0]["currency"];
            stock_status = value[0]["stock_status"];
            _increment = value[0]["increment"];
            _imageFuture = fetchImage(value[0]['image'] != false
                ? value[0]['image'][0]
                : 'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png');
            _is_auction_fee = value[0]["auction_fee_check"];
            reserveprice = value[0]["reserveprice"] == '' ? false : true;
            if (_is_auction_fee) {
              is_fee_paid = value[0]['fee_paid'];
              _auction_fee = value[0]["auction_fee"];
            }
            _is_buy_now = value[0]["buy_now_check"] == false ? false : true;
            if (_is_buy_now) {
              _buy_now = value[0]["buy_now"];
            }
            relatedProducts = value[0]['related_products'];
            bidders = value[0]['bidder'];
            maxBidUser = value[0]['maxbid'].toString();
            maxBidUserEmail = value[0]['user_email'].toString();
            currentUser = userid.toString();
            isFavorite = value[0]['watchlist'];
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      print('Failed to load products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter += _increment;
    });
  }

  void placeBidButtonHandler() async {
    setState(() {
      _isLoadingButton = true;
    });
    try {
      if (_is_auction_fee) {
        if (!is_fee_paid) {
          showPaymentPopup(
            context,
            "PAY THE FEE AND START NOW TO BID!",
            "This is a bidding fee auction. All participants must pay a fee of JOD $_auction_fee to place bids",
            true,
            "Pay Now",
            allData[0]['ID'].toString(),
            allData[0]['auction_fee'].toString(),
          );
          setState(() {
            _isLoadingButton = false;
          });
        } else if (is_fee_paid) {
          ApiService.getdata('ID').then((userid) {
            final body = jsonEncode({
              "user_id": userid.toString(),
              "bid": _counter,
              "product_id": allData[0]['ID'].toString(),
            });
            _apiService.place_bid(body).then((success) {
              if (success['status']) {
                popup.showPaymentPopup(
                  context,
                  success['message'],
                  'To see the latest details on the recent bids. Proceed to the product details screen.',
                  'See Product Details',
                  allData[0]['ID'].toString(),
                );
                setState(() {
                  _isLoadingButton = false;
                });
              }
            });
          });
        }
      } else {
        ApiService.getdata('ID').then((userid) {
          final body = jsonEncode({
            "user_id": userid.toString(),
            "bid": _counter,
            "product_id": allData[0]['ID'].toString(),
          });
          _apiService.place_bid(body).then((success) {
            if (success['status']) {
              popup.showPaymentPopup(
                context,
                success['message'],
                'To see the latest details on the recent bids. Proceed to the product details screen.',
                'See Product Details',
                allData[0]['ID'].toString(),
              );
              setState(() {
                _isLoadingButton = false;
              });
            }
          });
        });
      }
    } catch (e) {
      print("Error $e");
    }
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > _price) {
        _counter -= _increment;
      } else {
        _counter = _price;
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          centerTitle: false,
          leadingWidth: 40,
          backgroundColor: const Color(0xffF5F5F5),
          elevation: 0,
          title: Container(
            alignment: Alignment.topLeft,
            width: 140,
            // margin: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              'assets/image/logo.svg',
            ),
          ),
          automaticallyImplyLeading: true,
          actions: [
            InkWell(
              child: Container(
                height: 24,
                width: 24,
                margin: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  "assets/icon/home2.svg",
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => HomeScreen())));
              },
            ),
          ],
        ),
        body: _isLoading
            ? SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
            : allData.isNotEmpty
                ? ListView.builder(
                    itemCount: allData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Stack(children: [
                            Container(
                              margin: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? const EdgeInsets.only(
                                      top: 30, left: 20, right: 20)
                                  : const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                              width: screenWidth * 0.9,
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? screenHeight * 0.25
                                  : 150,
                              padding: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? const EdgeInsets.symmetric(vertical: 20)
                                  : const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: const Color(0xffffffff),
                              ),
                              child: FutureBuilder<ui.Image>(
                                future: _imageFuture,
                                builder: (BuildContext context,
                                    AsyncSnapshot<ui.Image> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return const Icon(Icons.error);
                                    } else if (snapshot.hasData) {
                                      return RawImage(
                                        image: snapshot.data,
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        height: 150,
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                            Positioned(
                              top: 30,
                              right: 20,
                              child: IconButton(
                                icon: Icon(isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                                color: isFavorite ? Colors.black : Colors.grey,
                                onPressed: () {
                                  ApiService.getdata('ID').then((userid) {
                                    final body = jsonEncode({
                                      "user_id": userid.toString(),
                                      "auction": allData[0]['ID'].toString(),
                                    });
                                    _apiService
                                        .add_to_watchlists(body)
                                        .then((success) {
                                      if (jsonDecode(success)['message'] ==
                                          'Added to Watchlist successfully') {
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                        const GetSnackBar(
                                          message: 'Item added to watchlist.',
                                          backgroundColor: Colors.grey,
                                          duration: Duration(seconds: 2),
                                          snackPosition: SnackPosition.TOP,
                                        ).show();
                                      } else if (jsonDecode(
                                              success)['message'] ==
                                          'Removed from Watchlist successfully') {
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                        const GetSnackBar(
                                          message:
                                              'Item removed from watchlist.',
                                          backgroundColor: Colors.grey,
                                          duration: Duration(seconds: 2),
                                          snackPosition: SnackPosition.TOP,
                                        ).show();
                                      } else {
                                        const GetSnackBar(
                                          message:
                                              'Something went wrong. Please try again.',
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
                          ]),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                ),
                                child: Text(
                                  reserveprice
                                      ? "Auction have reserve price."
                                      : "Auction does not have a reserve price.",
                                  style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          if (stock_status == 'outofstock')
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 15),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                alignment: Alignment.centerLeft,
                                width: Get.size.width,
                                height: 71,
                                color: const Color(0xffE2E2E2),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: const Text(
                                            "Out of stock",
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: const Text(
                                            'This auction has ended.',
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else ...[
                            if (currentUser == maxBidUser &&
                                DateTime.parse(allData[0]['auction_end_new'])
                                    .isBefore(DateTime.now()))
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 15, bottom: 30),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  alignment: Alignment.centerLeft,
                                  width: Get.size.width,
                                  decoration: BoxDecoration(
                                      color: const Color(0xfff8efdf),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xFFf0ce71))),
                                  // height: 91,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            color: const Color(0xffd07700),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            child: SvgPicture.asset(
                                              "assets/icon/trophy_transparent.svg",
                                              height: 30,
                                              width: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Congratulations!",
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        maxBidUserEmail,
                                        style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text.rich(TextSpan(children: [
                                        const TextSpan(
                                            text:
                                                'You won this auction with the final price of ',
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                        TextSpan(
                                            text:
                                                '$_currency ${_price - _increment}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                            )),
                                        const TextSpan(
                                            text:
                                                ' Be sure to pay for the product within 3 days to avoid losing it! ',
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ])),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        child: Container(
                                          width: screenWidth * 0.45,
                                          height: 32,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Pay Order",
                                              style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else if (currentUser != maxBidUser &&
                                DateTime.parse(allData[0]['auction_end_new'])
                                    .isBefore(DateTime.now()))
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 15, bottom: 30),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  alignment: Alignment.centerLeft,
                                  width: Get.size.width,
                                  decoration: BoxDecoration(
                                      color: const Color(0xfff8efdf),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xFFf0ce71))),
                                  // height: 91,
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "This auction has ended.",
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else ...[
                              if (currentUser == maxBidUser)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 15),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    alignment: Alignment.centerLeft,
                                    width: Get.size.width,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffEAF4F1),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xFFC3E8DD))),
                                    height: 91,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: const Text(
                                            "You are currently the highest bidder for this auction!",
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Text(
                                            "Your maximum bid: $_currency ${_price - _increment}",
                                            style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 15),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  alignment: Alignment.centerLeft,
                                  width: Get.size.width,
                                  height: 71,
                                  color: const Color(0xffE2E2E2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: const Text(
                                          "Time left to start auction:",
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.watch_later_outlined,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Row(
                                            children: [
                                              TimerCountdown(
                                                format: CountDownTimerFormat
                                                    .daysHoursMinutesSeconds,
                                                endTime: DateTime.parse(
                                                    allData[0]
                                                        ['auction_end_new']),
                                                // enableDescriptions: false,
                                                daysDescription: " Days",
                                                hoursDescription: " Hours",
                                                minutesDescription: " Minutes",
                                                secondsDescription: " Seconds",
                                                timeTextStyle: const TextStyle(
                                                    fontFamily: "Work Sans",
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                colonsTextStyle:
                                                    const TextStyle(
                                                        fontFamily: "Work Sans",
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                spacerWidth: 2,
                                                descriptionTextStyle:
                                                    const TextStyle(
                                                        fontFamily: "Work Sans",
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.only(left: 20, top: 5),
                                    child: const Text(
                                      "Auction ends: ",
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "${getDateTime(allData[0]['auction_end_new'])} CEST",
                                      style: const TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              if (_is_auction_fee && !is_fee_paid)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 15),
                                  child: InkWell(
                                    onTap: () {
                                      if (_is_auction_fee) {
                                        showPaymentPopup(
                                            context,
                                            "PAY THE FEE AND START NOW TO BID!",
                                            "This is a bidding fee auction. \n All participants must pay a fee of JOD $_auction_fee to place bids",
                                            true,
                                            "Pay Now",
                                            allData[0]['ID'].toString(),
                                            allData[0]['auction_fee']
                                                .toString());
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      alignment: Alignment.centerLeft,
                                      width: Get.size.width,
                                      decoration: BoxDecoration(
                                          color: const Color(0xfffff5e5),
                                          border: Border.all(
                                              width: 1,
                                              color: const Color(0xff8d4b00))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: const Text(
                                              "This is a bidding fee auction.",
                                              style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 16,
                                                  color: Color(0xff8d4b00),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            child: Text(
                                              "All participants must pay fee of $_auction_fee to place bids.",
                                              style: const TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 27),
                              Container(
                                margin: const EdgeInsets.only(left: 20, top: 0),
                                width: Get.size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Current Bid: ",
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "JOD ${_price - _increment}",
                                          style: const TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    if (_is_buy_now && _price < _buy_now)
                                      InkWell(
                                        onTap: () {
                                          showPaymentPopup(
                                              context,
                                              "Buy Now!",
                                              "Purchase it now for JOD $_buy_now",
                                              false,
                                              "Buy Now",
                                              allData[0]['ID'].toString(),
                                              allData[0]['buy_now'].toString());
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 20),
                                              child: Text(
                                                "Buy Now for JOD $_buy_now",
                                                style: const TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 19,
                              ),
                              Center(
                                child: Container(
                                  height: 1,
                                  width: screenWidth * .9,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: screenWidth * .9,
                                margin: const EdgeInsets.only(
                                    top: 0, left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "JOD",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      width: screenWidth * .35,
                                      height: 32,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.black)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const SizedBox(width: 15),
                                          InkWell(
                                              onTap: _decrementCounter,
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                                size: 20,
                                              )),
                                          const SizedBox(width: 15),
                                          Text(
                                            '$_counter',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(width: 15),
                                          InkWell(
                                              onTap: _incrementCounter,
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 20,
                                              )),
                                          const SizedBox(width: 15),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        placeBidButtonHandler();
                                      },
                                      child: Container(
                                        width: screenWidth * 0.45,
                                        height: 32,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                        ),
                                        child: Center(
                                          child: _isLoadingButton
                                              ? const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Text(
                                                  "BID JOD " +
                                                      _counter.toString(),
                                                  style: const TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 64
                                    : 30,
                              ),
                            ],
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, top: 0, bottom: 5),
                                  child: const Text(
                                    "Bids",
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            if (bidders.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 8, bottom: 20),
                                child: Table(
                                  border: TableBorder.all(),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: const {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(1),
                                    2: FlexColumnWidth(1),
                                  },
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300]),
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Bidder',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Bid Amount',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Bid Time',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ...bidders.map((bidder) {
                                      return TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              bidder["username"].toString(),
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "$_currency ${bidder["bid"].toString().split(".")[0]}",
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              getDateTime12Hour(
                                                  bidder["date"]!),
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            if (bidders.isEmpty)
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 0, bottom: 5),
                                    child: const Text(
                                      "There are no bids yet. Be the first!",
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            const SizedBox(height: 10),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       margin: const EdgeInsets.only(
                            //         left: 20,
                            //       ),
                            //       child: const Text(
                            //         'Related Products',
                            //         style: TextStyle(
                            //           fontFamily: 'Work Sans',
                            //           color: Colors.black,
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w400,
                            //         ),
                            //       ),
                            //     ),
                            //     InkWell(
                            //       onTap: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: ((context) => HomeScreen(
                            //                       index: 0,
                            //                     ))));
                            //       },
                            //       child: Row(
                            //         children: [
                            //           Container(
                            //             margin: EdgeInsets.only(right: 2),
                            //             child: Text(
                            //               'MORE',
                            //               style: TextStyle(
                            //                 fontFamily: 'Work Sans',
                            //                 color: Colors.black26,
                            //                 fontSize: 12,
                            //                 fontWeight: FontWeight.w400,
                            //               ),
                            //             ),
                            //           ),
                            //           Container(
                            //               margin: EdgeInsets.only(right: 20),
                            //               child: Icon(
                            //                 Icons.arrow_forward,
                            //                 color: Colors.black26,
                            //                 size: 16,
                            //               )),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 12),
                            // Center(
                            //   child: Container(
                            //       margin: EdgeInsets.only(left: 0, right: 20),
                            //       height: 130,
                            //       // width: screenWidth,
                            //       child: ListView.builder(
                            //         itemCount: relatedProducts.length,
                            //         scrollDirection: Axis.horizontal,
                            //         itemBuilder: (context, index) {
                            //           return Container(
                            //             width: screenWidth,
                            //             padding: EdgeInsets.only(left: 10, right: 10),
                            //             child:
                            //                 CardListWidget(product: relatedProducts[index]),
                            //           );
                            //         },
                            //       )),
                            // ),
                            // const SizedBox(
                            //   height: 50,
                            // ),
                          ]
                        ],
                      );
                    })
                : Center(
                    child: SizedBox(
                      width: screenWidth * .9,
                      child: const Text(
                        'No live auctions available with the given name.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ));
  }
}

class Cell1 extends StatelessWidget {
  final TextStyle? textStyle;
  final String text;
  final bool isValued;

  const Cell1({required this.text, this.textStyle, this.isValued = false});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Text(text,
            textAlign: TextAlign.center,
            style: textStyle ??
                TextStyle(
                    fontSize: 10,
                    color: isValued ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w400)),
      ),
    );
  }
}
