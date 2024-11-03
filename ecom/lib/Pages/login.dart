// ignore_for_file: unused_import

import 'package:aura/Pages/bottomnav.dart';
import 'package:aura/Pages/forgotpassword.dart';
import 'package:aura/Pages/signup.dart';
import 'package:aura/admin/admin_login.dart';
import 'package:aura/admin/home_admin.dart';
import 'package:aura/service/color.dart';
import 'package:aura/widget/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";

  final _formkey= GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLogin", true);
    } on FirebaseAuthException catch (e) {
  print("Firebase Auth Exception: ${e.message}");
  if (e.code == 'user-not-found') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "No User Found for that Email",
        style: TextStyle(fontSize: 18.0, color: Colors.black),
      ),
    ));
  } else if (e.code == 'wrong-password') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Wrong Password Provided by User",
        style: TextStyle(fontSize: 18.0, color: Colors.black),
      ),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        "No Authenticate User",
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
    ));
  }
}

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                     backgroundcolor,
                      Color.fromARGB(255, 231, 0, 100),
                    ])),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Text(""),
              ),
              Container(
                
                margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.7,
                        decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "Login",
                                style: AppWidget.HeadlineTextFieldStyle(),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                controller: useremailcontroller,
                                validator: (value){
                                  if(value==null|| value.isEmpty){
                                    return 'Please Enter Email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: AppWidget.smalltextfield(),
                                    prefixIcon: Icon(Icons.email_outlined)),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                 controller:userpasswordcontroller,
                                validator: (value){
                                  if(value==null|| value.isEmpty){
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: AppWidget.smalltextfield(),
                                    prefixIcon: Icon(Icons.password_outlined)),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                                },
                                child: Container(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(fontFamily: "POPPPINS" , color: Color.fromARGB(255, 44, 44, 50) , fontSize: 15 , fontWeight: FontWeight.w500),
                                    )),
                              ),
                              SizedBox(
                                height: 80.0,
                              ),
                              GestureDetector(
                                onTap: (){
                                  if(_formkey.currentState!.validate()){
                                    setState(() {
                                      email= useremailcontroller.text;
                                      password= userpasswordcontroller.text;
                                    });
                                  }
                                  userLogin();
                                },
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: button,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Center(
                                        child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontFamily: 'Poppins1',
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text(
                          "Don't have an account? Sign up",
                          style: TextStyle(fontFamily: "POPPPINS" , color: Color.fromARGB(255, 44, 44, 50) , fontSize: 15 , fontWeight: FontWeight.normal),
                        )),
                   
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                            icon: Icon(Icons.admin_panel_settings), // Icon for admin panel
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => AdminLogin()), // Navigate to admin home screen
                                              );
                                            },
                                          ),
                              ],
                            ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}