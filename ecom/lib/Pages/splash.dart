
import 'package:aura/Pages/bottomnav.dart';
import 'package:aura/Pages/onboard.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _MysplashState();
}
class _MysplashState extends State<SplashScreen> {
  @override
  void initState() {
    getBoolValuesSF();
    super.initState();
  }
  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool('isLogin') ?? false;
    if (boolValue) {
      Timer(const Duration(seconds: 4), () {
        prefs.setBool("isLogin", true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNav()));
      });
    } else {
      Timer(const Duration(seconds: 4), () {
         prefs.setBool("isLogin", false);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Onboard()));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("images/aura_logo.png")),
            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 3,
                width: 300,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}