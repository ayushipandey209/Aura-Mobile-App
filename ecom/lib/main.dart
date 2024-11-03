
// ignore_for_file: unused_import

import 'package:aura/Pages/bottomnav.dart';
import 'package:aura/Pages/forgotpassword.dart';
import 'package:aura/Pages/home.dart';
import 'package:aura/Pages/login.dart';
import 'package:aura/Pages/onboard.dart';
import 'package:aura/Pages/signup.dart';
import 'package:aura/Pages/splash.dart';
import 'package:aura/admin/add_items.dart';
import 'package:aura/admin/admin_login.dart';
import 'package:aura/admin/home_admin.dart';
import 'package:aura/widget/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';

void main()async {
 WidgetsFlutterBinding.ensureInitialized();
   Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp();
    
  runApp(const MyHomePage());
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: 
      false,
      home: SignUp(),
    );
  }
}
