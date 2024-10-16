import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/theme/theme_helper.dart';
import 'package:project/utils/size_utils.dart';
import 'package:project/widget/custom_text_field.dart';

class AccountDetaialScreen extends StatefulWidget {
  const AccountDetaialScreen({Key? key}) : super(key: key);

  @override
  _AccountDetaialScreenState createState() => _AccountDetaialScreenState();
}

class _AccountDetaialScreenState extends State<AccountDetaialScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _email = TextEditingController();
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmNewPassword = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _displayName = TextEditingController();
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode currentPasswordFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode newPasswordFocus = FocusNode();
  final FocusNode confirmNewPasswordFocus = FocusNode();
  final FocusNode displayNameFocus = FocusNode();

  @override
  void initState() {
    getAccountDetails();
    super.initState();
  }

  Future<void> getAccountDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userid = await ApiService.getdata('ID');
      final value = await ApiService().fetchUserdetails(userid.toString());
      setState(() {
        _firstName.text = value[0]['first_name'];
        _lastName.text = value[0]['last_name'];
        _displayName.text = value[0]['display_name'];
        _email.text = value[0]['email'];
      });
    } catch (e) {
      print('Error fetching account details: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userid = await ApiService.getdata('ID');
        final body = jsonEncode({
          "user_id": userid.toString(),
          "first_name": _firstName.text,
          "last_name": _lastName.text,
          "display_name": _displayName.text,
          "email": _email.text,
        });
        final success = await ApiService().update_user_details(body);
        print("Success: $success");
        // Handle success
      } catch (e) {
        // Handle errors here
        print('Error updating user details: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: appTheme.background,
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
            key: _formKey,
            child: Column(children: [
              if (_isLoading)
                SizedBox(
                    height: screenheight * .8,
                    child: const Center(child: CircularProgressIndicator()))
              else ...[
                Expanded(
                  child: SingleChildScrollView(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            padding:
                                EdgeInsets.only(top: 20.h, left: 20, right: 20),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "ACCOUNT DETAILS",
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )),

                                  const SizedBox(height: 20),
                                  // first Name
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'First Name *',
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14.56,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: 10.v),
                                        Container(
                                          // height: 30,
                                          child: CustomTextFormField(
                                              controller: _firstName,
                                              autofocus: false,
                                              fillColor:
                                                  const Color(0xffd9d9d9),
                                              filled: true,
                                              focusNode: firstNameFocus,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your First Name';
                                                }
                                                return null;
                                              },
                                              textStyle: const TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w400),
                                              textInputAction:
                                                  TextInputAction.done,
                                              textInputType: TextInputType.text,
                                              prefixConstraints:
                                                  const BoxConstraints(
                                                      maxHeight: 53)),
                                        )
                                      ],
                                    ),
                                  ),

                                  // last name
                                  Container(
                                    margin:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? const EdgeInsets.only(top: 20)
                                            : const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Last Name *',
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14.56,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: 10.v),
                                        Container(
                                          child: CustomTextFormField(
                                              controller: _lastName,
                                              autofocus: false,
                                              fillColor:
                                                  const Color(0xffd9d9d9),
                                              filled: true,
                                              focusNode: lastNameFocus,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your Last Name';
                                                }
                                                return null;
                                              },
                                              textStyle: const TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w400),
                                              textInputAction:
                                                  TextInputAction.done,
                                              textInputType: TextInputType.text,
                                              prefixConstraints:
                                                  const BoxConstraints(
                                                      maxHeight: 53)),
                                        )
                                      ],
                                    ),
                                  ),

                                  // Display name
                                  Container(
                                    margin:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? const EdgeInsets.only(top: 20)
                                            : const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Display Name *',
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14.56,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: 10.v),
                                        Container(
                                          child: CustomTextFormField(
                                              controller: _displayName,
                                              fillColor:
                                                  const Color(0xffd9d9d9),
                                              filled: true,
                                              autofocus: false,
                                              focusNode: displayNameFocus,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your Display Name';
                                                }
                                                return null;
                                              },
                                              textStyle: const TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w400),
                                              textInputAction:
                                                  TextInputAction.done,
                                              textInputType: TextInputType.text,
                                              prefixConstraints: BoxConstraints(
                                                  maxHeight: 53.v)),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'This will be how your name will be displayed in the account screen section and in review.',
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14.56,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),

                                  // Email Address
                                  Container(
                                    margin:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? const EdgeInsets.only(top: 20)
                                            : const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Email Address *',
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14.56,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: 10.v),
                                        Container(
                                          child: CustomTextFormField(
                                              controller: _email,
                                              enabled: false,
                                              fillColor:
                                                  const Color(0xffd9d9d9),
                                              filled: true,
                                              autofocus: false,
                                              focusNode: emailFocus,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your email.';
                                                }
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.done,
                                              textStyle: const TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14.56,
                                                  fontWeight: FontWeight.w400),
                                              textInputType: TextInputType.text,
                                              prefixConstraints: BoxConstraints(
                                                  maxHeight: 53.v)),
                                        )
                                      ],
                                    ),
                                  ),
                                ]))),
                  ),
                ),
                Center(
                  child: Container(
                      margin: const EdgeInsets.only(
                          right: 10, top: 10, left: 20, bottom: 10),
                      child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              ApiService.getdata('ID').then((userid) {
                                final body = jsonEncode({
                                  "user_id": userid.toString(),
                                  "first_name": _firstName.text,
                                  "last_name": _lastName.text,
                                  "display_name": _displayName.text,
                                  "email": _email.text
                                });

                                ApiService()
                                    .update_user_details(body)
                                    .then((success) {
                                  print("success $success");
                                  if (jsonDecode(success)['message'] ==
                                      'User updated successfully') {
                                    const GetSnackBar(
                                      message:
                                          'User details updated successfully.',
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
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(00),
                                color: Colors.black),
                            child: const Center(
                              child: Text(
                                "Save Changes",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ))),
                ),
              ]
            ])));
  }
}
