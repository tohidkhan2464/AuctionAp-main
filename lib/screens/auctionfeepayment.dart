import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/auth/api_service.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/popupTransactions.dart';
import 'package:project/widget/custom_text_field.dart';

class AuctionFeePayment extends StatefulWidget {
  final fee;
  final order_id;
  final auctionid;
  const AuctionFeePayment(
      {super.key,
      required this.fee,
      required this.order_id,
      required this.auctionid});

  @override
  State<AuctionFeePayment> createState() => _AuctionFeePaymentState();
}

class _AuctionFeePaymentState extends State<AuctionFeePayment> {
  final formkey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode billing_address_1Focus = FocusNode();
  final FocusNode billing_address_2Focus = FocusNode();
  final FocusNode billing_cityFocus = FocusNode();
  final FocusNode billing_stateFocus = FocusNode();
  final FocusNode billing_postcodeFocus = FocusNode();
  final FocusNode billing_first_nameFocus = FocusNode();
  final FocusNode billing_last_nameFocus = FocusNode();
  final FocusNode billing_phoneFocus = FocusNode();
  final FocusNode billing_emailFocus = FocusNode();
  bool _isloading = false;
  String product_name = 'Auction Name';
  var _currency = 'JOD';
  late Future<ui.Image> _imageFuture = _loadPlaceholderImage();
  final TextEditingController billing_address_1 = TextEditingController();
  final TextEditingController billing_address_2 = TextEditingController();
  final TextEditingController billing_city = TextEditingController();
  final TextEditingController billing_state = TextEditingController();
  final TextEditingController billing_postcode = TextEditingController();
  final TextEditingController billing_first_name = TextEditingController();
  final TextEditingController billing_last_name = TextEditingController();
  final TextEditingController billing_phone = TextEditingController();
  final TextEditingController billing_email = TextEditingController();
  var popup = PopupTransactions();

  @override
  void initState() {
    print("AuctionFee Payment");
    getbillingdetails();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  PaymentSdkConfigurationDetails generateConfig(billingdetails, orderid) {
    setState(() {
      _isloading = true;
    });

    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.AMAN);
    final configuration = PaymentSdkConfigurationDetails(
        profileId: "145138",
        serverKey: "S6J9RZKLNK-JJHGBGBML6-MWGDMG2ZBH",
        clientKey: "C7K266-RQD266-HT2T2N-V2G99P",
        cartId: orderid.toString(),
        cartDescription: "test",
        merchantName: "Raqamak VIP",
        screentTitle: "Pay with Card",
        amount: double.parse(widget.fee),
        forceShippingInfo: false,
        showBillingInfo: false,
        billingDetails: billingdetails,
        currencyCode: "JOD",
        merchantCountryCode: "JO",
        alternativePaymentMethods: apms,
        linkBillingNameWithCardHolderName: true);

    configuration.iOSThemeConfigurations = IOSThemeConfigurations(
      logoImage: 'assets/image/hashLogo.png',
      primaryColor: '#ffffff',
      primaryFontColor: '#000000',
      secondaryColor: '#1B1B1B',
      secondaryFontColor: '#000000',
      strokeColor: '#d9d9d9',
      buttonColor: '#000000',
      buttonFontColor: '#ffffff',
      titleFontColor: '#000000',
      backgroundColor: '#f4f4f4',
      placeholderColor: '#6D6D6D',
      strokeThinckness: 1,
      inputsCornerRadius: 0,
      inputFieldBackgroundColor: '#d9d9d9',
    );

    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

  Future<ui.Image> _loadPlaceholderImage() async {
    const placeholderUrl =
        'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png';
    return fetchImage(placeholderUrl);
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

  Future<void> payPressed(billingdetails, orderid) async {
    FlutterPaytabsBridge.startPaymentWithSavedCards(
        generateConfig(billingdetails, orderid), true, (event) {
      print('returned from gateway');
      setState(() {
        if (event["status"] == "success") {
          var transactionDetails = event["data"];
          print("Event received: $event");
          if (transactionDetails["isSuccess"]) {
            print(
                "Transaction completed successfully: ${transactionDetails['transactionReference']}");
            final body = jsonEncode({
              "order_id": orderid.toString(),
              "_transaction_id": transactionDetails['transactionReference'],
              "transaction_type": transactionDetails['transactionType'],
              "_payment_tokens": transactionDetails['token'],
            });
            print("Request payload: $body");
            ApiService().changeOrderStatus(body).then((success) {
              var data = jsonDecode(success);
              print("Order status updated: $data");
              _isloading = false;
              popup.showPaymentPopup(
                  context,
                  "Payment Confirmed",
                  "Thank you! Your payment has been received, and you can now continue with your bidding.",
                  "Go to Transactions",
                  widget.auctionid);
            });

            if (transactionDetails["isPending"]) {
              print("Transaction is awaiting confirmation");
              _isloading = false;
              popup.showPaymentPopup(
                  context,
                  "Payment Under Review",
                  "Your payment is currently being processed. Please check back shortly.",
                  "Check Transactions Status",
                  widget.order_id);
            }
          } else {
            print("Transaction could not be completed");
            _isloading = false;
            popup.showPaymentPopup(
                context,
                "Payment Unsuccessful",
                "We encountered an issue processing your payment. Please try again or contact support.",
                "Return to Transactions",
                widget.order_id);
          }
        } else if (event["status"] == "error") {
          print("Error occurred: $event");
          _isloading = false;
          popup.showPaymentPopup(
              context,
              "Payment Error",
              "An error occurred while processing your payment. Please try again or seek assistance.",
              "Return to Transactions",
              widget.order_id);
        } else if (event["status"] == "event") {
          print("Event received: $event");
          _isloading = false;
          popup.showPaymentPopup(
              context,
              event['message'],
              "You have canceled the payment. If this was a mistake, please try again.",
              "Go Back to Transactions",
              widget.order_id);
        }
      });
    });
  }

  void getbillingdetails() async {
    setState(() {
      _isloading = true;
    });
    try {
      final userid = await ApiService.getdata('ID');
      ApiService().fetchbillingdetails(userid.toString()).then((value) {
        billing_address_1.text = value['billing_address_1'];
        billing_address_2.text = value['billing_address_2'];
        billing_city.text = value['billing_city'];
        billing_state.text = value['billing_state'];
        billing_postcode.text = value['billing_postcode'];
        billing_first_name.text = value['billing_first_name'];
        billing_last_name.text = value['billing_last_name'];
        billing_phone.text = value['billing_phone'];
        billing_email.text = value['billing_email'];
      });
      ApiService().fetchOrderDetails(widget.order_id.toString()).then((value) {
        print("winning value $value");
        if (mounted) {
          setState(() {
            product_name = value['products'][0]['title'];
            _currency = value["currency"];
            _imageFuture = fetchImage(value['products'][0]['product_image'] !=
                    false
                ? value['products'][0]['product_image'][0]
                : 'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png');
            _isloading = false;
          });
        }
      });
    } catch (e) {
      print('Failed to load products: $e');
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          backgroundColor: const Color(0xffF5F5F5),
          elevation: 0,
          centerTitle: false,
          leadingWidth: 40,
          title: Container(
            // height: 34,
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
        body: _isloading
            ? SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
            : Form(
                key: formkey,
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(children: [
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, top: 20),
                          child: const Row(
                            children: [
                              Text(
                                'YOUR ORDER DETAILS',
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 10),
                          width: screenWidth * 1,
                          child: Row(
                            children: [
                              Container(
                                width: 62,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                              SizedBox(
                                width: screenWidth * .8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: Text(
                                            product_name,
                                            style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, top: 5),
                                          child: Text(
                                            "$_currency ${widget.fee}",
                                            style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, top: 10, right: 20),
                              child: const Text(
                                'Total',
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 20),
                              child: Text(
                                "$_currency ${widget.fee.toString()}",
                                style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 2,
                          width: screenWidth,
                          color: Colors.black,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            child: const Text(
                              'BILLING DETAILS',
                              style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'First Name *',
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14.56,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  // SizedBox(height: 5),
                                  SizedBox(
                                    height: 40,
                                    width: screenWidth * .4,
                                    child: CustomTextFormField(
                                        controller: billing_first_name,
                                        autofocus: false,
                                        focusNode: billing_first_nameFocus,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your First Name';
                                          }
                                          return null;
                                        },
                                        textStyle: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14.56,
                                            fontWeight: FontWeight.w400),
                                        fillColor: const Color(0xffd9d9d9),
                                        filled: true,
                                        textInputAction: TextInputAction.done,
                                        textInputType: TextInputType.text,
                                        prefixConstraints: const BoxConstraints(
                                            maxHeight: 50)),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Last Name *',
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14.56,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  // SizedBox(height: 10.v),
                                  SizedBox(
                                    height: 40,
                                    width: screenWidth * .4,
                                    child: CustomTextFormField(
                                        controller: billing_last_name,
                                        autofocus: false,
                                        focusNode: billing_last_nameFocus,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your Last Name';
                                          }
                                          return null;
                                        },
                                        textStyle: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14.56,
                                            fontWeight: FontWeight.w400),
                                        fillColor: const Color(0xffd9d9d9),
                                        filled: true,
                                        textInputAction: TextInputAction.done,
                                        textInputType: TextInputType.text,
                                        prefixConstraints: const BoxConstraints(
                                            maxHeight: 50)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Street address *',
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14.56,
                                    fontWeight: FontWeight.w400),
                              ),
                              // SizedBox(height: 10.v),
                              SizedBox(
                                height: 40,
                                child: CustomTextFormField(
                                    controller: billing_address_1,
                                    autofocus: false,
                                    focusNode: billing_address_1Focus,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Last Name';
                                      }
                                      return null;
                                    },
                                    textStyle: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14.56,
                                        fontWeight: FontWeight.w400),
                                    fillColor: const Color(0xffd9d9d9),
                                    filled: true,
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.text,
                                    prefixConstraints:
                                        const BoxConstraints(maxHeight: 50)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Town / City *',
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14.56,
                                    fontWeight: FontWeight.w400),
                              ),
                              // SizedBox(height: 10.v),
                              SizedBox(
                                height: 40,
                                child: CustomTextFormField(
                                    controller: billing_address_2,
                                    focusNode: billing_address_2Focus,
                                    autofocus: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Town / City';
                                      }
                                      return null;
                                    },
                                    textStyle: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14.56,
                                        fontWeight: FontWeight.w400),
                                    fillColor: const Color(0xffd9d9d9),
                                    filled: true,
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.text,
                                    prefixConstraints:
                                        const BoxConstraints(maxHeight: 50)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'State *',
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14.56,
                                    fontWeight: FontWeight.w400),
                              ),
                              // SizedBox(height: 10.v),
                              SizedBox(
                                height: 40,
                                child: CustomTextFormField(
                                    controller: billing_state,
                                    focusNode: billing_stateFocus,
                                    autofocus: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your State';
                                      }
                                      return null;
                                    },
                                    textStyle: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14.56,
                                        fontWeight: FontWeight.w400),
                                    fillColor: const Color(0xffd9d9d9),
                                    filled: true,
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.text,
                                    prefixConstraints:
                                        const BoxConstraints(maxHeight: 50)),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email *',
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14.56,
                                    fontWeight: FontWeight.w400),
                              ),
                              // SizedBox(height: 5),
                              SizedBox(
                                height: 40,
                                child: CustomTextFormField(
                                    controller: billing_email,
                                    focusNode: billing_emailFocus,
                                    autofocus: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Email';
                                      }
                                      return null;
                                    },
                                    textStyle: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14.56,
                                        fontWeight: FontWeight.w400),
                                    fillColor: const Color(0xffd9d9d9),
                                    filled: true,
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.text,
                                    prefixConstraints:
                                        const BoxConstraints(maxHeight: 50)),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    )),
                    Center(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isloading = true;
                            });
                            if (formkey.currentState!.validate()) {
                              ApiService.getdata('ID').then((userid) {
                                final body = jsonEncode({
                                  "user_id": userid.toString(),
                                  "fee_price": widget.fee,
                                  "product_id": widget.order_id,
                                  "billing_address_1": billing_address_1.text,
                                  "billing_address_2": billing_address_2.text,
                                  "billing_city": billing_city.text,
                                  "billing_state": billing_state.text,
                                  "billing_postcode": billing_postcode.text,
                                  "billing_first_name": billing_first_name.text,
                                  "billing_last_name": billing_last_name.text,
                                  "billing_phone": billing_phone.text,
                                  "billing_email": billing_email
                                      .text.removeAllWhitespace
                                      .toLowerCase()
                                });

                                final billingdetails = BillingDetails(
                                    "${billing_first_name.text} ${billing_last_name.text}",
                                    billing_email.text.removeAllWhitespace
                                        .toLowerCase(),
                                    billing_phone.text,
                                    "${billing_address_1.text} ${billing_address_2.text}",
                                    "JO",
                                    billing_city.text,
                                    billing_state.text,
                                    "00000");

                                payPressed(
                                    billingdetails, widget.order_id.toString());
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 20, left: 20, top: 20, bottom: 10),
                            height: 53,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.black,
                            ),
                            child: const Center(
                              child: Text(
                                "Proceed to Pay",
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // ListView(),
              ));
  }
}
