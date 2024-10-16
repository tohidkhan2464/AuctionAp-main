import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/itemdetail.dart';

// Initialize the favorites list
List<CustomCardListWidget> favorites = [];

class CustomCardListWidget extends StatefulWidget {
  final String? title;
  final String? price;
  final Map<String, dynamic> item;

  CustomCardListWidget({
    Key? key,
    this.title,
    this.price,
    required this.item,
  }) : super(key: key);

  @override
  _CustomCardListWidgetState createState() => _CustomCardListWidgetState();
}

class _CustomCardListWidgetState extends State<CustomCardListWidget> {
  bool isFavorite = false;
  late Future<ui.Image> _imageFuture;

  @override
  void initState() {
    super.initState();
    // Load image from URL using the new API
    _imageFuture = loadImageFromUrl(widget.item['featured_src'] ??
        'https://app.raqamak.vip/wp-content/uploads/2024/04/5-3.png');
  }

  Future<ui.Image> loadImageFromUrl(String url) async {
    final Uri resolved = Uri.base.resolve(url);
    final ByteData data = await NetworkAssetBundle(resolved).load("");
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Access the item property here
    Map<String, dynamic> item = widget.item;

    // Extract data from the item map
    String title = item['title'] ?? 'No Title';
    String time = item['time'] ?? 'No Time';
    String price = item['price'] ?? 'No Price';
    String imageUrl = item['featured_src'] ??
        'https://app.raqamak.vip/wp-content/uploads/2024/04/5-3.png';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetail(
              data: widget.item,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
            height: 118,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      width: 80,
                      margin: EdgeInsets.only(top: 10, left: 10),
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        child: Text(
                          time,
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: screenWidth * .32,
                      height: 45,
                      child:
                          // Text(
                          //   title,
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //       fontSize: 16,
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.bold),
                          // )
                          FutureBuilder<ui.Image>(
                        future: _imageFuture,
                        builder: (BuildContext context,
                            AsyncSnapshot<ui.Image> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Icon(Icons.error);
                            } else {
                              return RawImage(
                                image: snapshot.data,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 45,
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 2),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Auction with Automatic bid',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8.0, bottom: 5),
                      height: 0.6,
                      width: screenWidth * .45,
                      color: Colors.grey,
                    ),
                    Container(
                      width: screenWidth * .45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Current bid:",
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            "JOD " + price,
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: screenHeight * .03,
                      width: screenWidth * .45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Color(0xff181816),
                      ),
                      child: Center(
                        child: Text(
                          'Allocated to You',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 18,
            child: IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite; // Toggle favorite state
                  if (isFavorite) {
                    // Add the card to favorites list
                    favorites.add(CustomCardListWidget(
                      title: widget.title,
                      price: widget.price,
                      item: widget.item,
                    ));
                  } else {
                    // Remove the card from favorites list
                    favorites.removeWhere((element) =>
                        element.title == widget.title &&
                        element.price == widget.price &&
                        element.item == widget.item);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
