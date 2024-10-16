import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/widget/favoritecard.dart';

//List<dynamic> favorites = [];

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  bool isVisible = false;
  bool _isLoading = false;

  List<dynamic> favorites = [];
  List<dynamic> _filteredFavorites = [];

  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _getProducts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _getProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = await ApiService.getdata('ID');
      final response = await _apiService.fetch_watchlists(userId.toString());
      print('_getProducts fetch_watchlists: $response');
      final currentDate = DateTime.now();
      final filteredItems = response.where((item) {
        final itemDate = DateTime.parse(item['auction_end_new']);
        return itemDate.isAfter(currentDate) ||
            itemDate.isAtSameMomentAs(currentDate);
      }).toList();

      setState(() {
        favorites = filteredItems;
        _filteredFavorites = filteredItems;
        _isLoading = false;
      });
    } catch (e) {
      print('_getProducts failed: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        _filteredFavorites = favorites;
      });
    } else {
      setState(() {
        _filteredFavorites = favorites.where((item) {
          return item['post_title'].toLowerCase().contains(query);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xfff4f4f4),
        key: _scaffoldKey,
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!isVisible)
                    const Text(
                      "FAVORITES",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  if (isVisible)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: screenWidth <= 360 ? 27 : 30,
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? screenWidth * .8
                              : screenWidth,
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth <= 360 ? 12 : 14,
                            ),
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: "Enter the product name",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                              contentPadding:
                                  EdgeInsets.only(bottom: 5, left: 5),
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                        if (!isVisible) {
                          _searchController.text = '';
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 2),
                        child: Row(
                          children: [
                            Center(
                              child: isVisible
                                  ? const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 24,
                                    )
                                  : const FaIcon(
                                      FontAwesomeIcons.sliders,
                                      color: Colors.black,
                                      size: 22,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredFavorites.isNotEmpty
                      ? ListView.builder(
                          itemCount: _filteredFavorites.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: FavCardListWidget(
                                product: _filteredFavorites[index],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Container(
                            width: screenWidth * .9,
                            child: Text(
                              'Add an auction to watchlist to see it here!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
            ),
          ],
        ));
  }
}
