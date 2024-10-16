import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/theme/theme_helper.dart';
import 'package:project/utils/size_utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenwidth = mediaQueryData.size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: appTheme.background,
        body: ListView(children: [
          Form(
              key: _formKey,
              child: SizedBox(
                  width: double.maxFinite,
                  child: Stack(alignment: Alignment.topCenter, children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 28.h, vertical: 50),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Logo
                                  Center(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: SvgPicture.asset(
                                          "assets/image/hash.svg"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 38,
                                  ),

                                  // Forgot Password Text
                                  const Align(
                                      alignment: Alignment.center,
                                      child: Text("Forgot Password",
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 32,
                                              color: Color(0xff2A1F1F),
                                              fontWeight: FontWeight.w400))),
                                  SizedBox(height: 27.v),

                                  // Email / UserName
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Username or Email Address *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            color: Color(0xff1F1F1F),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 8.5.v),
                                      Container(
                                        height: 50,
                                        child: TextFormField(
                                          controller: _emailController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(0xff7A7A7A),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(0xff7A7A7A),
                                                width: 1.0,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(0xff7A7A7A),
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(0xff7A7A7A),
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your username';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25.v),

                                  // Send OTP button
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      final body = jsonEncode(
                                          {"email": _emailController.text});
                                      ApiService()
                                          .forgotPassword(body)
                                          .then((success) {
                                        const GetSnackBar(
                                          message:
                                              'Reset Link send Successfully.',
                                          backgroundColor: Colors.grey,
                                          duration: Duration(seconds: 2),
                                          snackPosition: SnackPosition.TOP,
                                        ).show();
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      });
                                    },
                                    child: Container(
                                      color: const Color(0xff181816),
                                      height: 53,
                                      width: screenwidth * .9,
                                      child: Center(
                                        child: _isLoading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const Text(
                                                "Reset Password",
                                                style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 16,
                                                    color: Color(0xff8B8B8A),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 14.v),
                                ])))
                  ]))),
        ]));
  }
}
