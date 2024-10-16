import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/widget/historycardlistwidget.dart';
// import 'package:project/widget/mobilebottomsheet.dart';

class HistoryView extends StatefulWidget {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  Future<String> getJson() {
    return rootBundle.loadString("assets/data/licenseplate.json");
  }

  bool isvisible = false;
  final _searchController = TextEditingController();

  List<dynamic> _products = [];
  List<dynamic> _filteredProducts = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((item) {
        return item["title"].toLowerCase().contains(query);
      }).toList();
    });
  }

  void _loadData() async {
    String jsonString = await getJson();
    List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      _products = jsonData;
      _filteredProducts = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
        title: Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(
            "BIDDING HISTORY",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Work Sans",
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          if (isvisible)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: screenWidth <= 360 ? 27 : 30,
                  width: screenWidth * .8,
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth <= 360 ? 12 : 14,
                    ),
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Enter the product name",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.only(bottom: 5, left: 5),
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
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xff7A7A7A),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () {
                  setState(() {
                    isvisible = !isvisible;
                  });
                },
                child: Container(
                  // padding: EdgeInsets.only(right: 20),
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: isvisible
                        ? Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24,
                          )
                        : FaIcon(
                            FontAwesomeIcons.sliders,
                            color: Colors.black,
                            size: 24,
                          ),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        isvisible = !isvisible;
                        // _searchController.text = '';
                      });
                    },
                  ),
                )),
          )
        ],
      ),
      body: _filteredProducts.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(bottom: 30),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child:
                      HistoryCardListWidget(product: _filteredProducts[index]),
                );
              },
            )
          : Center(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Text('No Data found.'),
            ),
    );
  }
}
