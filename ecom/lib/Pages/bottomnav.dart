
// ignore_for_file: duplicate_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aura/Pages/home.dart';
import 'package:aura/Pages/Item.dart';
import 'package:aura/Pages/profile.dart';
import 'package:aura/Pages/wallet.dart';
import 'package:aura/service/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Assuming you're using the curved_navigation_bar package

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Profile profile;
  late Order order;
  late Wallet wallet;


  @override
  void initState() {
    homepage = Home();
    order = Order();
    wallet = Wallet();
    profile = Profile();

    pages = [homepage, order,wallet, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.white,
          color: nav,
          animationDuration: Duration(milliseconds: 300),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.wallet_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outline,
              color: Colors.white,
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}