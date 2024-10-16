import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/about.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/licenseplate.dart';
import 'package:project/screens/mobilenumber.dart';
import 'package:project/screens/profilesscreen.dart';
import 'package:project/widget/MyBidsCustomBottomSheet.dart';
import 'package:project/widget/bid_cardlist_Widget.dart';

class MybidsScreen extends StatefulWidget {
  const MybidsScreen({super.key});

  @override
  State<MybidsScreen> createState() => _MybidsScreenState();
}

class _MybidsScreenState extends State<MybidsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic> _applied_filters = {
    'code': '',
    'status': null,
    'minPrice': 300.0,
    'maxPrice': 1500000.0
  };
  List<dynamic> _products = [];
  List<dynamic> _filteredProducts = [];
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  void _getProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String userid = await ApiService.getdata('ID');
      final response = await _apiService.fetchAuctions(userid.toString());
      print('MY BIDS _products : $response');

      setState(() {
        _products = response;
        _filteredProducts = response;
        _isLoading = false;
      });
    } catch (e) {
      // print('_products failed: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  void _applyFilter(Map<String, dynamic> filters) {
    setState(() {
      _applied_filters = filters;
      _isLoading = true;
      _filteredProducts = _products.where((product) {
        bool matches = true;

        if (filters['code'] != null && filters['code'].isNotEmpty) {
          matches =
              matches && product['product_name'].startsWith(filters['code']);
        }

        if (filters['status'] != null) {
          var type = filters['status'];
          matches = matches && product['status'] == type;
        }

        double price = double.tryParse(product['max_bid_value']) ?? 0.0;
        matches = matches &&
            price >= filters['minPrice'] &&
            price <= filters['maxPrice'];

        return matches;
      }).toList();

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xffF5F5F5),
      endDrawer: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Drawer(
          backgroundColor: const Color(0xff181816),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 50),
              ListTile(
                leading: Image.asset(
                  'assets/icon/home2.png',
                  width: 30,
                  color: Colors.grey,
                ),
                title: const Text(
                  'Home Page',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => HomePage())));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icon/licenceplate.png',
                  width: 30,
                  color: Colors.grey,
                ),
                title: const Text(
                  'Licence Plate',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const LicencePlate())));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icon/mobile.png',
                  width: 30,
                ),
                title: const Text(
                  'Mobile Number',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const MobileNumber())));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icon/about.png',
                  width: 30,
                ),
                title: const Text(
                  'About',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AboutScreen())));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icon/profile.png',
                  width: 30,
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const ProfileScreen())));
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "MY BIDS",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return CustomMyBidsBottomSheet(
                          onFilter: (_applied_filters) {
                            _applyFilter(_applied_filters);
                          },
                          initialFilters: _applied_filters,
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 2),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.sliders,
                            color: Colors.black,
                            size: 22,
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
            child: Container(
              color: const Color(0xffF5F5F5),
              margin: const EdgeInsets.only(top: 5),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredProducts.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: CustomBidCardListWidget(
                                  product: _filteredProducts[index]),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            'Make your first bid to see your auctions here!',
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
      ),
    );
  }
}
