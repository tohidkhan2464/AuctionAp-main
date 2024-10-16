import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/theme/theme_helper.dart';
import 'package:project/utils/size_utils.dart';

import '../auth/api_service.dart';

// ignore_for_file: must_be_immutable
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool loading = false;

  // bool _visibilityConfirmPassword = true;
  bool _visibilityPassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  final ApiService _apiService = ApiService();
  void _signup() async {
    setState(() {
      loading = true;
    });
    try {
      final response = await _apiService.signup({
        "email": _emailController.text,
        "first_name": _firstNameController.text,
        "password": _passwordController.text,
        "last_name": _lastNameController.text,
        "phone": _phoneController.text,
      });
      print("response $response");
      if (response.containsKey('success')) {
        print('Signup success');
        ApiService.saveSessiondata('is_loggedin', 'true');
        ApiService.saveSessiondata('userdata', response["user"].toString());
        ApiService.saveSessiondata('token', response["data"]['jwt'].toString());
        ApiService.saveSessiondata(
            'ID', response["user"]['data']['ID'].toString());
        print('Login successful: $response');
        const GetSnackBar(
          message: 'Logged in Successfully.',
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
        ).show();
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => HomeScreen())));
      } else if (response.containsKey('error')) {
        print("error $response");
        GetSnackBar(
          message: response["error"],
          backgroundColor: Colors.grey,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
        ).show();
      } else {
        const GetSnackBar(
          message: 'Something went wrong. Please try again.',
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
        ).show();
      }
    } catch (error) {
      print("Error $error");
      GetSnackBar(
        message: error.toString(),
        backgroundColor: Colors.grey,
        duration: const Duration(seconds: 2),
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
        backgroundColor: appTheme.background,
        resizeToAvoidBottomInset: true,
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
                                horizontal: 28.h, vertical: 28.v),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Logo
                                  Center(
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: SvgPicture.asset(
                                          "assets/image/hash.svg"),
                                    ),
                                  ),

                                  // Sign Up Text
                                  const Align(
                                      alignment: Alignment.center,
                                      child: Text("Sign Up",
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 32,
                                              color: Color(0xff2A1F1F),
                                              fontWeight: FontWeight.w400))),
                                  SizedBox(height: 18.v),

                                  // Username / First Name
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'First Name *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 12.v),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: _firstNameController,
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
                                      )
                                    ],
                                  ),

                                  // Last Name
                                  SizedBox(height: 10.v),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Last Name *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 12.v),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: _lastNameController,
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
                                              return 'Please enter your Last Name';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.v),

                                  // Email

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Email *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 12.v),
                                      SizedBox(
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
                                              return 'Please enter your Email.';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.v),

                                  // Phone Number
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Phone Number *',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 12.v),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: _phoneController,
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
                                              return 'Please enter your Phone Number.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.v),

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
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 12.v),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          obscureText: _visibilityPassword,
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
                                                _visibilityPassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _visibilityPassword =
                                                      !_visibilityPassword;
                                                });
                                              },
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your Password.';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.v),

                                  // Remember Me
                                  Row(
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
                                                    return Colors
                                                        .white; // Color of the checkbox when checked
                                                  }
                                                  return Colors.grey.withOpacity(
                                                      0.4); // Color of the checkbox when unchecked
                                                },
                                              ),
                                              activeColor: Colors
                                                  .white, // Color of the checkbox when checked
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
                                    ],
                                  ),
                                  SizedBox(height: 15.v),

                                  // Sign Up
                                  InkWell(
                                    onTap: () {
                                      _signup();
                                    },
                                    child: Container(
                                      color: const Color(0xff181816),
                                      height: 53,
                                      width: screenwidth * .9,
                                      child: loading
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Center(
                                              child: Text(
                                                "Sign Up",
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

                                  // Already have account
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Already have an account?',
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              color: Color(0xffa7a7a7),
                                              fontWeight: FontWeight.w400)),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      const LoginScreen())));
                                        },
                                        child: const Text("Sign In",
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                color: Color(0xff1f1f1f),
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                ])))
                  ]))),
        ]));
  }

  /// Navigates to the otpVerifyScreen when the action is triggered.
  // onTapLogin(BuildContext context) {
  //   Navigator.pushReplacementNamed(context, AppRoutes.otpVerifyScreen);
  // }
}
