import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/utils/size_utils.dart';

class checkoutdetailpg extends StatefulWidget {
  final userData;
  const checkoutdetailpg({super.key, required this.userData});

  @override
  State<checkoutdetailpg> createState() => _checkoutdetailpgState();
}

class _checkoutdetailpgState extends State<checkoutdetailpg> {
  final FocusNode cardNumberFocus = FocusNode();
  final FocusNode expiryDateFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode nameOnCardFocus = FocusNode();
  bool _isLoading = false;
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expiryDate = TextEditingController();
  final TextEditingController cvv = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController nameOnCard = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    var data = jsonDecode(widget.userData);
    print("user ${data['price'].runtimeType}");
    price.text = (data['price']);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xfff5f5f5),
      resizeToAvoidBottomInset: true,
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
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    child: const Text(
                      'PAY WITH CARD',
                      style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Card Number *',
                              style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14.56,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.v),
                        TextFormField(
                          controller: cardNumber,
                          focusNode: cardNumberFocus,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CardNumberFormatter(),
                          ],
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'XXXX XXXX XXXX XXXX',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            filled: true,
                            fillColor: const Color(0xffd9d9d9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.h),
                              borderSide: const BorderSide(
                                color: Color(0xffd9d9d9),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.h),
                              borderSide: const BorderSide(
                                color: Color(0xffd9d9d9),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.h),
                              borderSide: const BorderSide(
                                color: Color(0xffd9d9d9),
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.h),
                              borderSide: const BorderSide(
                                color: Color(0xffd9d9d9),
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.h),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            errorStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.5),
                              fontSize: 14.fSize,
                            ),
                            counterText: '',
                          ),
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14.56,
                              fontWeight: FontWeight.w400),
                          maxLength: 19,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Last Name.';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            top: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Expiry Date *',
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14.56,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 10.v),
                              Container(
                                width: mediaQueryData.orientation ==
                                        Orientation.portrait
                                    ? screenWidth * .4
                                    : screenWidth * .45,
                                child: TextFormField(
                                  controller: expiryDate,
                                  focusNode: expiryDateFocus,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(5),
                                    ExpireDateFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'MM/YY',
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    filled: true,
                                    fillColor: const Color(0xffd9d9d9),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.h),
                                      borderSide: const BorderSide(
                                        color: Color(0xffd9d9d9),
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.h),
                                      borderSide: const BorderSide(
                                        color: Color(0xffd9d9d9),
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.h),
                                      borderSide: const BorderSide(
                                        color: Color(0xffd9d9d9),
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.h),
                                      borderSide: const BorderSide(
                                        color: Color(0xffd9d9d9),
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.h),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    errorStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.5),
                                      fontSize: 14.fSize,
                                    ),
                                    counterText: '',
                                  ),
                                  style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14.56,
                                      fontWeight: FontWeight.w400),
                                  maxLength: 5,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Last Name.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            right: 20,
                            top: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'CVV *',
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14.56,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 10.v),
                              Container(
                                width: mediaQueryData.orientation ==
                                        Orientation.portrait
                                    ? screenWidth * .4
                                    : screenWidth * .45,
                                child: TextFormField(
                                  controller: cvv,
                                  focusNode: cvvFocus,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                    // ExpireDateFormatter(separator: "/"), // *Here*
                                  ],
                                  decoration: InputDecoration(
                                    hintText: '123',
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    filled: true,
                                    fillColor: const Color(0xffd9d9d9),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.h),
                                      borderSide: const BorderSide(
                                        color: Color(0xffd9d9d9),
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.h),
                                      borderSide: const BorderSide(
                                        color: Color(0xffd9d9d9),
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.h),
                                      borderSide: const BorderSide(
                                        color: Color(0xffd9d9d9),
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.h),
                                      borderSide: const BorderSide(
                                        color: Color(0xffd9d9d9),
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.h),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    errorStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.5),
                                      fontSize: 14.fSize,
                                    ),
                                    counterText: '',
                                  ),
                                  style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14.56,
                                      fontWeight: FontWeight.w400),
                                  maxLength: 3,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Last Name.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Name on Card',
                              style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14.56,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.v),
                        TextFormField(
                          controller: nameOnCard,
                          focusNode: nameOnCardFocus,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'NAME SURNAME',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            filled: true,
                            fillColor: const Color(0xffd9d9d9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.h),
                              borderSide: const BorderSide(
                                color: Color(0xffd9d9d9),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.h),
                              borderSide: const BorderSide(
                                color: Color(0xffd9d9d9),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.h),
                              borderSide: const BorderSide(
                                color: Color(0xffd9d9d9),
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.h),
                              borderSide: const BorderSide(
                                color: Color(0xffd9d9d9),
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.h),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            errorStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.5),
                              fontSize: 14.fSize,
                            ),
                            counterText: '',
                          ),
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14.56,
                              fontWeight: FontWeight.w400),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Last Name.';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          textCapitalization: TextCapitalization.words,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Amount to be Paid',
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14.56,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 10.v),
                        Container(
                          // height: 50,
                          width: screenWidth,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(00),
                              color: const Color(0xffd9d9d9)),
                          child: Text(
                            "JOD ${price.text.toString()}",
                            style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14.56,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Center(
              child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 30),
                  child: InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          ApiService().buy_now(widget.userData).then((success) {
                            var data = jsonDecode(success)[0];
                            // print("buy now $data");

                            final body = jsonEncode({
                              "profile_id": 145138,
                              "tran_type": "sale",
                              "tran_class": "moto",
                              "cart_id": data['ID'].toString(),
                              "cart_currency": "JOD",
                              "cart_amount": int.parse(price.text),
                              "cart_description":
                                  "Description of the items/services",
                              "paypage_lang": "en",
                              "customer_details": {
                                "name":
                                    "${data['billing_address']['first_name']} ${data['billing_address']['last_name']}",
                                "email":
                                    data['billing_address']['email'].toString(),
                                "phone":
                                    data['billing_address']['phone'].toString(),
                                "street1":
                                    "${data['billing_address']['address_1']} ${data['billing_address']['address_2']}",
                                "city":
                                    data['billing_address']['city'].toString(),
                                "state":
                                    data['billing_address']['state'].toString(),
                                "country": data['billing_address']['country']
                                    .toString(),
                                "zip": data['billing_address']['postcode']
                                    .toString(),
                                "ip": "1.1.1.1"
                              },
                              "shipping_details": {
                                "name":
                                    "${data['shipping_address']['first_name']} ${data['shipping_address']['last_name']}",
                                "email":
                                    data['billing_address']['email'].toString(),
                                "phone":
                                    data['billing_address']['phone'].toString(),
                                "street1":
                                    "${data['shipping_address']['address_1']} ${data['shipping_address']['address_2']}",
                                "city":
                                    data['shipping_address']['city'].toString(),
                                "state": data['shipping_address']['state']
                                    .toString(),
                                "country": data['shipping_address']['country']
                                    .toString(),
                                "zip": data['shipping_address']['postcode']
                                    .toString()
                              },
                              "callback": "",
                              "return": "",
                              "card_details": {
                                "pan": cardNumber.text
                                    .replaceAll(" ", "")
                                    .toString(),
                                "cvv": cvv.text.toString(),
                                "expiry_month":
                                    int.parse(expiryDate.text.split("/")[0]),
                                "expiry_year":
                                    int.parse(expiryDate.text.split('/')[1]) +
                                        2000,
                              }
                            });
                            ApiService().paymentRequest(body).then((success) {
                              var data = jsonDecode(success);
                              print("paymentRequest data $data");
                            });
                            // print("body for request ${(body)}");
                          });
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(right: 20, left: 20, top: 10),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(00),
                            color: Colors.black),
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
            )
          ],
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class ExpireDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    if (newText.length < oldValue.text.length) return newValue;

    var result = "";

    if (newText.contains("/")) {
      final dates = newText.split("/");
      final month = dates.first;
      final year = dates.last;
      if (year.length >= 2) {
        result = "$month/${year.substring(0, 2)}";
      } else {
        result = newText;
      }
    } else {
      if (newText.length == 2) {
        result = "$newText/";
      } else {
        result = newText;
      }
    }

    return newValue.copyWith(
      text: result,
      selection: TextSelection.fromPosition(
        TextPosition(offset: result.length),
      ),
    );
  }
}
