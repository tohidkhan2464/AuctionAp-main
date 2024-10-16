import 'package:flutter/material.dart';
import 'package:project/screens/about.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/licenseplate.dart';
import 'package:project/screens/mobilenumber.dart';
import 'package:project/screens/profilesscreen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  static List<Widget> _screens = [
    MobileNumber(),
    LicencePlate(),
    HomePage(),
    AboutScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = _screens[index] as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        _buildBottomNavigationBarItem(Icons.call, 'Mobile', 1),
        _buildBottomNavigationBarItem(Icons.shopping_cart, 'Cart', 2),
        _buildBottomNavigationBarItem(Icons.home_filled, 'Home', 0),
        _buildBottomNavigationBarItem(Icons.notifications, 'Notifications', 3),
        _buildBottomNavigationBarItem(Icons.person, 'Profile', 4),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: BottomNavItem(
        icon: icon,
        // label: label,
        isSelected: _selectedIndex == index,
      ),
      label: label,
    );
  }
}

class BottomNavItem extends StatefulWidget {
  final IconData icon;
  // final String label;
  final bool isSelected;

  const BottomNavItem({
    required this.icon,
    // required this.label,
    required this.isSelected,
  });

  @override
  _BottomNavItemState createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<BottomNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward(); // Example usage of AnimationController

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          widget.icon,
          color: widget.isSelected ? Colors.blue : Colors.grey,
        ),
        // SizedBox(height: 4),
        // Text(
        //   widget.label,
        //   style: TextStyle(
        //     color: widget.isSelected ? Colors.blue : Colors.grey,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ],
    );
  }
}
