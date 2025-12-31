import 'package:flutter/material.dart';

import '../nav_pages/home_nav_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Widget> mPages = [
    HomeNavPage(),
    HomeNavPage(),
    HomeNavPage(),
    HomeNavPage(),
    HomeNavPage(),
  ];

  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mPages[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                selectedIndex = 0;
                setState(() {});
              },
              icon: Icon(
                Icons.menu_open_rounded,
                color: selectedIndex==0 ? Color(0xffFF650E).withAlpha(100) : Colors.black26,
                size: 32,
              ),
            ),
            IconButton(
              onPressed: () {
                selectedIndex = 1;
                setState(() {});
              },
              icon: Icon(
                Icons.favorite_border,
                color: selectedIndex==1 ? Color(0xffFF650E).withAlpha(100) : Colors.black26,
                size: 32,
              ),
            ),
            SizedBox(width: 70),
            IconButton(
              onPressed: () {
                selectedIndex = 3;
                setState(() {});
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: selectedIndex==3 ? Color(0xffFF650E).withAlpha(100) : Colors.black26,
                size: 32,
              ),
            ),
            IconButton(
              onPressed: () {
                selectedIndex = 4;
                setState(() {});
              },
              icon: Icon(
                Icons.account_circle_outlined,
                color: selectedIndex==4 ? Color(0xffFF650E).withAlpha(100) : Colors.black26,
                size: 32,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFF650E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        onPressed: () {
          selectedIndex = 2;
          setState(() {});
        },
        child: Icon(Icons.home_outlined, color: Colors.white),
      ),
    );
  }
}
