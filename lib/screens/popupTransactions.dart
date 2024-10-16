import 'package:flutter/material.dart';
import 'package:project/screens/transaction_screen.dart';

class PopupTransactions extends StatelessWidget {
  const PopupTransactions({super.key});

  void showPaymentPopup(BuildContext context, String title, String text,
      String buttonText, productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // print("height ${MediaQuery.of(context).size.height}");
        // print("width ${MediaQuery.of(context).size.width}");
        var screenHeight = MediaQuery.of(context).size.height;
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
                        if (title == "Purchase Confirmed" ||
                            title == "Payment Confirmed") {
                          int count = 0;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Transactions(),
                              ), (Route<dynamic> route) {
                            return count++ == 3;
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Icon(
                        Icons.close,
                        size: 24,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    height: 32,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        if (title == "Purchase Confirmed" ||
                            title == "Payment Confirmed") {
                          int count = 0;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Transactions(),
                              ), (Route<dynamic> route) {
                            return count++ == 3;
                          });
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const Transactions())));
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
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
