// ignore_for_file: prefer_const_constructors, unnecessary_new, use_build_context_synchronously

import 'package:aura/Pages/signup.dart';
import 'package:aura/service/color.dart';
import 'package:aura/widget/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController mailcontroller = new TextEditingController();

  String email = "";

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Password Reset Email has been sent !",
        style: TextStyle(fontSize: 18.0),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 18.0),
        )));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 70.0,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "Password Recovery",
                style: TextStyle(
                    color:  Colors.black,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold),
              ),
              
            ),
            Container(
              width: 330,
              height: 1,
              color: Colors.black54,
              child: Divider()),
            SizedBox(
              height: 29.0,
            ),
            Text(
              "Enter your Email",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: Form(
                  key: _formkey,
                    child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color:  Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      controller: mailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                      style: TextStyle(color:  Colors.black),
                      decoration: InputDecoration(
                        
                          hintText: "Email",
                          hintStyle:
                              AppWidget.smalltextfield(),
                          prefixIcon: Icon(
                            Icons.person,
                            color:  Colors.black,
                            size: 30.0,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: (){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        email= mailcontroller.text;
                      });
                      resetPassword();
                    }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27),
                      child: Container(
                        
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                        
                            color:  button,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Send Email",
                            style: TextStyle(
                                color:  const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 18.0, color:  Colors.black),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          "Create",
                          style: TextStyle(
                              color: Color.fromARGB(225, 184, 166, 6),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))),
          ],
        ),
      ),
    );
  }
}