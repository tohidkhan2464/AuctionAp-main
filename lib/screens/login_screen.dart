import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/screens/forgotPassword.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/singnup.dart';
import 'package:project/theme/theme_helper.dart';
import 'package:project/utils/size_utils.dart';

import '../auth/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool loading = false;
  bool _visibilityText = false;

  void _login() async {
    setState(() {
      loading = true;
    });
    try {
      final response = await _apiService.login({
        "email": _emailController.text,
        "password": _passwordController.text,
      });

      if (response["success"] == true) {
        ApiService.saveSessiondata('is_loggedin', 'true');
        ApiService.saveSessiondata(
            'userdata', response["data"]['user_data']['data'].toString());
        ApiService.saveSessiondata('token', response["data"]['jwt'].toString());
        ApiService.saveSessiondata(
            'ID', response["data"]['user_data']['data']['ID'].toString());
        print('Login successful: $response');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => HomeScreen())));
        const GetSnackBar(
          message: 'Logged in Successfully.',
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
        ).show();
      }
    } catch (e) {
      const GetSnackBar(
        message: 'Invalid Credentials',
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      ).show();
    }
    setState(() {
      loading = false;
    });
  }

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

                                  // Sign In Text
                                  const Align(
                                      alignment: Alignment.center,
                                      child: Text("Sign In",
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
                                            // labelText: 'Username',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(
                                                    0xff7A7A7A), // Change this to your desired border color
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(
                                                    0xff7A7A7A), // Change this to your desired focused border color
                                                width:
                                                    1.0, // Change the width if needed
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(
                                                    0xff7A7A7A), // Change this to your desired error border color
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: Color(
                                                    0xff7A7A7A), // Change this to your desired focused error border color
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

                                  // Password
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Password *',
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
                                            controller: _passwordController,
                                            decoration: InputDecoration(
                                              // labelText: 'Username',
                                              border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.zero,
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      0xff7A7A7A), // Change this to your desired border color
                                                ),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.zero,
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      0xff7A7A7A), // Change this to your desired focused border color
                                                  width:
                                                      1.0, // Change the width if needed
                                                ),
                                              ),
                                              errorBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.zero,
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      0xff7A7A7A), // Change this to your desired error border color
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.zero,
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      0xff7A7A7A), // Change this to your desired focused error border color
                                                  width: 1.0,
                                                ),
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _visibilityText
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visibilityText =
                                                        !_visibilityText;
                                                  });
                                                },
                                              ),
                                            ),
                                            obscureText: !_visibilityText,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your password';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ]),
                                  SizedBox(height: 17.v),

                                  // Remember Me
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        transform: Matrix4.translationValues(
                                            -5.0, 0.0, 0.0),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: _rememberMe,
                                              onChanged: (value) {
                                                setState(() {
                                                  _rememberMe = value!;
                                                });
                                              },
                                              fillColor: MaterialStateProperty
                                                  .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.selected)) {
                                                    return Colors.white;
                                                  }
                                                  return const Color(
                                                      0xffD9D9D9);
                                                },
                                              ),
                                              activeColor: Colors.white,
                                              checkColor: Colors.black,
                                            ),
                                            const Text(
                                              "Remember Me",
                                              style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 12,
                                                  color: Color(0xff1F1F1F),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgotPassword()),
                                          );
                                        },
                                        child: Container(
                                            child: const Text(
                                                "Forget Password?",
                                                style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    color: Color(0xffa7a7a7),
                                                    fontWeight:
                                                        FontWeight.w400))),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.v),

                                  // Sign In button
                                  InkWell(
                                    onTap: () {
                                      _login();
                                    },
                                    child: Container(
                                      color: const Color(0xff181816),
                                      height: 53,
                                      width: screenwidth * .9,
                                      child: Center(
                                        child: loading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const Text(
                                                "Sign In",
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

                                  // Don't have account
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: const Text(
                                            'Don’t have an account?',
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                color: Color(0xffa7a7a7),
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      const SignupScreen())));
                                        },
                                        child: Container(
                                            child: const Text("SignUp",
                                                style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    color: Color(0xff1f1f1f),
                                                    fontWeight:
                                                        FontWeight.w400))),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 40),
                                ])))
                  ]))),
        ]));
  }
}
