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
import 'package:project/screens/popup.dart';
import 'package:project/widget/custom_text_field.dart';

class checkoutbidpg extends StatefulWidget {
  final price;
  final auction;
  const checkoutbidpg({super.key, required this.price, required this.auction});

  @override
  State<checkoutbidpg> createState() => _checkoutbidpgState();
}

class _checkoutbidpgState extends State<checkoutbidpg> {
  final FocusNode billing_address_1Focus = FocusNode();
  final FocusNode billing_address_2Focus = FocusNode();
  final FocusNode billing_cityFocus = FocusNode();
  final FocusNode billing_stateFocus = FocusNode();
  final FocusNode billing_postcodeFocus = FocusNode();
  final FocusNode billing_first_nameFocus = FocusNode();
  final FocusNode billing_last_nameFocus = FocusNode();
  final FocusNode billing_phoneFocus = FocusNode();
  final FocusNode billing_emailFocus = FocusNode();
  String product_name = 'Product Item';
  bool _isLoading = false;
  String _currency = 'JOD';
  Popup popup = Popup();
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
  final formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (!mounted) return;
    getDetails();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<ui.Image> _loadPlaceholderImage() async {
    const placeholderUrl =
        'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png';
    return fetchImage(placeholderUrl);
  }

  PaymentSdkConfigurationDetails generateConfig(billingdetails, orderid) {
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
        amount: double.parse(widget.price),
        forceShippingInfo: false,
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

  Future<void> payPressed(billingdetails, orderid) async {
    print("buy now order id $orderid");
    FlutterPaytabsBridge.startPaymentWithSavedCards(
        generateConfig(billingdetails, orderid), true, (event) {
      print('returned from gateway');
      setState(() {
        if (event["status"] == "success") {
          var transactionDetails = event["data"];
          print("buy now Event received: $event");

          if (transactionDetails["isSuccess"]) {
            print(
                "Transaction completed successfully: ${transactionDetails['transactionReference']}");

            final body = jsonEncode({
              "order_id": orderid.toString(),
              "_transaction_id": transactionDetails['transactionReference'],
              "transaction_type": transactionDetails['transactionType'],
              "_payment_tokens": transactionDetails['token'],
            });

            ApiService().orderprocess(body).then((success) {
              var data = jsonDecode(success);
              print("buy now Order status updated: $data");
              _isLoading = false;
              popup.showPaymentPopup(
                  context,
                  "Purchase Confirmed",
                  "Your purchase was successful. Click to view your transaction details.",
                  "View Transaction Details",
                  widget.auction);
            });

            if (transactionDetails["isPending"]) {
              print("Transaction is awaiting confirmation");
              _isLoading = false;
              popup.showPaymentPopup(
                  context,
                  "Payment Processing",
                  "Your payment is currently being processed. Please check back shortly for the latest status.",
                  "Check Transaction Status",
                  widget.auction);
            }
          } else {
            print("Transaction could not be completed");
            _isLoading = false;
            popup.showPaymentPopup(
                context,
                "Payment Not Successful",
                "We were unable to complete your transaction. Please try again or contact support for assistance.",
                "Go to Product Details",
                widget.auction);
          }
        } else if (event["status"] == "error") {
          print("Error occurred: $event");
          _isLoading = false;
          popup.showPaymentPopup(
              context,
              "Payment Error",
              "An issue occurred while processing your payment. Please try again later or contact customer support.",
              "Go to Product Details",
              widget.auction);
        } else if (event["status"] == "event") {
          print("Event received: $event");
          _isLoading = false;
          popup.showPaymentPopup(
              context,
              event['message'],
              "The transaction has been canceled. If this was a mistake, please try again.",
              "Return to Product",
              widget.auction);
        }
      });
    });
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

  void getDetails() async {
    setState(() {
      _isLoading = true;
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

      ApiService()
          .getProductdetailsnew(widget.auction.toString(), userid.toString())
          .then((value) {
        setState(() {
          product_name = value[0]['post_title'];
          _currency = value[0]["currency"];
          _imageFuture = fetchImage(value[0]['image'] != false
              ? value[0]['image'][0]
              : 'https://app.raqamak.vip/wp-content/uploads/woocommerce-placeholder-800x450.png');
          _isLoading = false;
        });
      });
    } catch (e) {
      print("Error $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xffF5F5F5),
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
      body: _isLoading
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
                          margin: const EdgeInsets.only(top: 10, left: 20),
                          width: screenWidth * 1,
                          child: Row(
                            children: [
                              Container(
                                // height: 40,
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
                                          // height: 150,
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
                              Container(
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
                                              left: 10, right: 20, top: 5),
                                          child: Text(
                                            "$_currency ${widget.price.toString()}",
                                            style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, top: 0),
                                      child: const Text(
                                        'QUANTITY: 1',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 2,
                          width: screenWidth,
                          color: Colors.black,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: 20,
                                top: 5,
                              ),
                              child: const Text(
                                'Subtotal',
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 10, top: 5, right: 20),
                              child: Text(
                                "$_currency ${widget.price.toString()}",
                                style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
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
                                "$_currency ${widget.price.toString()}",
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
                        Row(children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: const Text(
                              'BILLING DETAILS',
                              style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ]),
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
                                  Container(
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
                                  Container(
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
                              Container(
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
                              Container(
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
                              Container(
                                child: CustomTextFormField(
                                    controller: billing_state,
                                    focusNode: billing_stateFocus,
                                    autofocus: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your State ';
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
                        // Container(
                        //   margin: const EdgeInsets.symmetric(
                        //       horizontal: 20, vertical: 10),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       const Text(
                        //         'Phone *',
                        //         style: TextStyle(
                        //             fontFamily: "Work Sans",
                        //             fontSize: 14.56,
                        //             fontWeight: FontWeight.w400),
                        //       ),
                        //       // SizedBox(height: 5),
                        //       Container(
                        //         child: CustomTextFormField(
                        //             controller: billing_phone,
                        //             focusNode: billing_phoneFocus,
                        //             autofocus: false,
                        //             validator: (value) {
                        //               if (value == null || value.isEmpty) {
                        //                 return 'Please enter your Phone Number';
                        //               }
                        //               return null;
                        //             },
                        //             textStyle: const TextStyle(
                        //                 fontFamily: "Work Sans",
                        //                 fontSize: 14.56,
                        //                 fontWeight: FontWeight.w400),
                        //             fillColor: const Color(0xffd9d9d9),
                        //             filled: true,
                        //             textInputAction: TextInputAction.done,
                        //             textInputType: TextInputType.text,
                        //             prefixConstraints:
                        //                 const BoxConstraints(maxHeight: 50)),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
                              Container(
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
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                    ),
                  ),
                  Center(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              _isLoading = true;
                            });
                            if (formkey.currentState!.validate()) {
                              ApiService.getdata('ID').then((userid) {
                                final body = jsonEncode({
                                  "user_id": userid.toString(),
                                  "price": widget.price,
                                  "product_id": widget.auction,
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
                                      .toLowerCase(),
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
                                    '00000');

                                // print(body);
                                ApiService().buy_now(body).then((success) {
                                  var data = jsonDecode(success)[0];
                                  print("data $data");
                                  payPressed(billingdetails, data['ID']);
                                });
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            width: screenWidth,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.black,
                            ),
                            child: Center(
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Pay Now",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ))),
                ],
              ),
            ),
    );
  }
}
