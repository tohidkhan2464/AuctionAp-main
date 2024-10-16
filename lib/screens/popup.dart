import 'package:flutter/material.dart';
import 'package:project/screens/itemdetail.dart';
import 'package:project/screens/transaction_screen.dart';

class Popup extends StatelessWidget {
  void showPaymentPopup(BuildContext context, String title, String text,
      String buttonText, productId) {
    print("title $title");
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
                                builder: (context) => const Transactions(),
                              ), (Route<dynamic> route) {
                            return count++ == 2;
                          });
                        } else if (title == "Successful Transaction") {
                          int count = 0;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ItemDetail(data: productId),
                              ), (Route<dynamic> route) {
                            return count++ == 2;
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
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
                        int count = 0;
                        if (title == "Purchase Confirmed" ||
                            title == "Payment Confirmed") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Transactions(),
                              ), (Route<dynamic> route) {
                            return count++ == 2;
                          });
                        } else if (title == "Successful Transaction") {
                          int count = 0;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ItemDetail(data: productId),
                              ), (Route<dynamic> route) {
                            return count++ == 2;
                          });
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDetail(
                                data: productId,
                              ),
                            ),
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

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
