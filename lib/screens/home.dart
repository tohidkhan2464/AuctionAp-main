import 'package:flutter/material.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/widget/cardWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // late BetterPlayerController _betterPlayerController;
  List<dynamic> _plateNumbers = [];
  List<dynamic> _mobileNumbers = [];
  bool _isLoading = false;
  final ApiService _apiService = ApiService();
  void _getProducts(category) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userid = await ApiService.getdata('ID');

      final response =
          await _apiService.fetchProductlistnew(category, userid.toString());

      DateTime currentDate = DateTime.now();
      List<dynamic> filteredItems = response.where((item) {
        DateTime itemDate = DateTime.parse(item['auction_end_new']);
        return itemDate.isAfter(currentDate) ||
            itemDate.isAtSameMomentAs(currentDate);
      }).toList();

      setState(() {
        if (category == 'mobile-numbers') {
          _mobileNumbers = filteredItems;
        } else {
          _plateNumbers = filteredItems;
        }
        _isLoading = false;
      });
    } catch (e) {
      print('_products failed : $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // BetterPlayerDataSource dataSource = BetterPlayerDataSource(
    //   BetterPlayerDataSourceType.network,
    //   "https://app.raqamak.vip/wp-content/uploads/2021/05/high.mp4",
    // );
    // _betterPlayerController = BetterPlayerController(
    //   BetterPlayerConfiguration(
    //     // aspectRatio: 3 / 4,
    //     autoPlay: true,
    //     looping: true,
    //     controlsConfiguration: BetterPlayerControlsConfiguration(
    //       showControls: false,
    //     ),
    //     showPlaceholderUntilPlay: true,
    //     placeholder: Center(
    //       child: Image.asset('assets/image/HomeBg.jpg'),
    //     ),
    //     errorBuilder: (context, errorMessage) {
    //       return Center(
    //         child: Text(
    //           "Error: $errorMessage",
    //           style: TextStyle(color: Colors.white),
    //         ),
    //       );
    //     },
    //   ),
    //   betterPlayerDataSource: dataSource,
    // );
    if (!mounted) return;
    _getProducts('license-plate');
    _getProducts('mobile-numbers');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      key: _scaffoldKey,
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              Image.asset(
                "assets/image/HomeBg.jpg",
                height: 300,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Your spot
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          bottom: 12,
                        ),
                        child: const Text(
                          'YOUR SPOT TO BUY OR SELL',
                          style: TextStyle(
                            fontFamily: 'Work Sans',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Your Premium
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          bottom: 14,
                        ),
                        child: const Text(
                          'YOUR PREMIUM',
                          style: TextStyle(
                            fontFamily: 'Work sans',
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // number
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          bottom: 5,
                        ),
                        child: const Text(
                          'NUMBER',
                          style: TextStyle(
                            fontFamily: 'Work Sans',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 33,
          ),

          // Featured plate numbers heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  'FEATURED PLATE NUMBERS',
                  style: TextStyle(
                    fontFamily: 'Work sans',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => HomeScreen(
                                index: 1,
                              ))));
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 2),
                      child: const Text(
                        'MORE',
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                          color: Colors.black26,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.black26,
                          size: 16,
                        )),
                  ],
                ),
              )
            ],
          ),

          // premium plate numbers subheading
          Container(
            margin: const EdgeInsets.only(left: 20, top: 6),
            child: const Text(
              'PREMIUM PLATE NUMBERS',
              style: TextStyle(
                fontFamily: 'Work Sans',
                color: Colors.black38,
                fontWeight: FontWeight.w100,
                fontSize: 10,
              ),
            ),
          ),

          // card list
          Container(
              margin: const EdgeInsets.only(top: 18, left: 10, right: 10),
              width: screenWidth * .9,
              height: 160,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _plateNumbers.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _plateNumbers.length > 6
                              ? 6
                              : _plateNumbers.length,
                          itemBuilder: (context, index) {
                            return CustomCardWidget(
                                product: _plateNumbers[index]);
                          },
                        )
                      : const Center(
                          child: Text(
                            'No live auctions available.',
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
          const SizedBox(
            height: 33,
          ),

          // Featured plate numbers heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  'FEATURED MOBILE NUMBERS',
                  style: TextStyle(
                    fontFamily: 'Work sans',
                    color: Colors.black,
                    fontSize: 16,
                    // fontVariations: FontVariation.,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => HomeScreen(
                                index: 2,
                              ))));
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 2),
                      child: const Text(
                        'MORE',
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                          color: Colors.black26,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.black26,
                          size: 16,
                        )),
                  ],
                ),
              )
            ],
          ),

          // premium plate numbers subheading
          Container(
            margin: const EdgeInsets.only(left: 20, top: 6),
            child: const Text(
              'PREMIUM MOBILE NUMBERS ',
              style: TextStyle(
                fontFamily: 'Work Sans',
                color: Colors.black38,
                fontWeight: FontWeight.w100,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),

          // card list
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: screenWidth * .9,
              height: 160,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _mobileNumbers.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _mobileNumbers.length > 6
                              ? 6
                              : _mobileNumbers.length,
                          itemBuilder: (context, index) {
                            return CustomCardWidget(
                                product: _mobileNumbers[index]);
                          },
                        )
                      : const Center(
                          child: Text(
                            'No live auctions available.',
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
