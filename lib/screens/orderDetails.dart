import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/popup.dart';
import 'package:project/utils/getTimeFromDateAndTime.dart';

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, required this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late String currency;
  late String name;
  late String streetAddress1;
  late String streetAddress2;
  late String city;
  late String country;
  late String state;
  late String postCode;
  late String phone;
  late String email;
  late String status;
  List<dynamic> products = [];
  var title;
  var order_subtotal;
  var order_total;
  var date;
  var allData = {};
  bool _isLoading = false;
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

  void _getProducts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ApiService.getdata('ID').then((userid) async {
        ApiService().fetchOrderDetails(widget.data.toString()).then((value) {
          print(value);
          if (mounted) {
            setState(() {
              allData = value;
              title = "#${value['id']}";
              date = getDate(value['date_created']);
              currency = value["currency"];
              order_subtotal = value["order_subtotal"];
              order_total = value["order_total"];
              status = value["order_status"];
              products = value['products'];
              name =
                  "${value['order_billing_first_name']} ${value['order_billing_last_name']}";
              streetAddress1 = value['order_billing_address_1'];
              streetAddress2 = value['order_billing_address_2'];
              city = value['order_billing_city'];
              state = value['order_billing_state'];
              country = value['order_billing_country'];
              postCode = value['order_billing_postcode'];
              phone = value['order_billing_phone'];
              email = value['order_billing_email'];
            });
          }
        });
      });
    } catch (e) {
      print('Failed to load products: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ') // Split the string by spaces to get individual words
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' '); // Join the capitalized words back into a single string
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
        backgroundColor: const Color(0xffF5F5F5),
        elevation: 0,
        centerTitle: false,
        leadingWidth: 40,
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
      body: allData.isNotEmpty
          ? ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: Text.rich(TextSpan(children: [
                              const TextSpan(
                                  text: 'Order ',
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Work Sans",
                                    fontSize: 14,
                                  )),
                              const TextSpan(
                                  text: ' was placed on ',
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: date,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Work Sans",
                                    fontSize: 14,
                                  )),
                              const TextSpan(
                                  text: ' and is currently ',
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: "$status.",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Work Sans",
                                    fontSize: 14,
                                  ))
                            ])),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, top: 0, bottom: 5),
                            child: const Text(
                              "ORDER DETAILS",
                              style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
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
                          },
                          children: [
                            TableRow(
                              decoration:
                                  BoxDecoration(color: Colors.grey[300]),
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Product',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            // Generate rows dynamically based on products list
                            ...products
                                .where((product) =>
                                    product['title'] != "Auction fee")
                                .map((product) {
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${product['title']} x ${product['quantity'].toString()}",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$currency ${product['order_total'].toString()}",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                            if (products[0]['title'] != "Auction fee")
                              TableRow(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "SubTotal :",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$currency ${order_subtotal.toString()}",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Total :",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "$currency ${order_total.toString()}",
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "BILLING ADDRESS",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                          },
                          children: [
                            _buildTableRow(capitalizeEachWord(name)),
                            _buildTableRow(capitalizeEachWord(streetAddress1)),
                            _buildTableRow(capitalizeEachWord(streetAddress2)),
                            _buildTableRow(capitalizeEachWord(city)),
                            _buildTableRow(capitalizeEachWord(state)),
                            TableRow(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone_outlined,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      phone,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.mail_outline,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      email,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 27),
                    ],
                  ),
                );
              })
          : SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}

TableRow _buildTableRow(String value) {
  return TableRow(
    children: [
      Text(
        value,
        style: const TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    ],
  );
}
