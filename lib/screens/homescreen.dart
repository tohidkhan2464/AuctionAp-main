import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/licenseplate.dart';
import 'package:project/screens/mobilenumber.dart';
import 'package:project/screens/myBids_screen.dart';
import 'package:project/screens/profilesscreen.dart';

class HomeScreen extends StatefulWidget {
  final index;
  HomeScreen({this.index});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static List<Widget> _pages = [
    HomePage(),
    LicencePlate(),
    MobileNumber(),
    MybidsScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.index ?? 0;
    _pageController = PageController(initialPage: widget.index ?? 0);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        // margin: EdgeInsets.only(top: 30),
        child: Drawer(
          backgroundColor: Color(0xff181816),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 50),
              ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(
                    "assets/icon/home1.svg",
                    // semanticsLabel: 'My SVG Image',
                    // height: 20,
                    // width: 20,
                  ),
                ),
                title: Text(
                  'Home Page',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  _onItemTapped(0);
                  _onPageChanged(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(
                    "assets/icon/licence-plate-2.svg",
                  ),
                ),
                title: Text(
                  'Licence Plate',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  _onItemTapped(1);
                  _onPageChanged(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(
                    'assets/icon/Vector.svg',
                  ),
                ),
                title: Text(
                  'Mobile Number',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  _onItemTapped(2);
                  _onPageChanged(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(
                    "assets/icon/basket1.svg",
                  ),
                ),
                title: Text(
                  'My Bids',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  _onItemTapped(3);
                  _onPageChanged(3);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(
                    "assets/icon/user3.svg",
                  ),
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  _onItemTapped(4);
                  _onPageChanged(4);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor:
            _selectedIndex == 0 ? Color(0xff000000) : Color(0xffF5F5F5),
        elevation: 0,
        centerTitle: false,
        leadingWidth: 0,
        title: Container(
          // height: 34,
          alignment: Alignment.topLeft,
          width: 140,
          margin: EdgeInsets.only(left: 0),
          child: SvgPicture.asset(
            _selectedIndex == 0
                ? 'assets/image/logo2.svg'
                : 'assets/image/logo.svg',
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: _selectedIndex == 0 ? Color(0xffffffff) : Colors.black,
                size: 26,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTabChanged: _onItemTapped,
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(
              0, null, 'assets/icon/home1.svg', selectedIndex, onTabChanged),
          _buildTabItem(1, null, 'assets/icon/licence-plate-2.svg',
              selectedIndex, onTabChanged),
          _buildTabItem(
              2, null, 'assets/icon/Vector.svg', selectedIndex, onTabChanged),

          _buildTabItem(
              3, null, 'assets/icon/basket1.svg', selectedIndex, onTabChanged),
          // _buildTabItem(4, Icons.person, null, selectedIndex, onTabChanged),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, IconData? iconData, String? imagePath,
      int selectedIndex, Function(int) onTap) {
    bool isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Container(
        child: Container(
          transform: isSelected
              ? Matrix4.translationValues(0, -10, 0)
              : Matrix4.translationValues(0, 0, 0),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Color(0xff4d4d4d) : Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  color: isSelected ? Colors.white : Colors.grey,
                  size: 24,
                )
              else if (imagePath != null)
                Container(
                  height: 24,
                  width: 30,
                  child: SvgPicture.asset(
                    imagePath,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
