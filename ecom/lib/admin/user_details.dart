import 'dart:async';

import 'package:aura/service/database.dart';
import 'package:aura/service/shared_pref.dart';
import 'package:aura/widget/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserState();
}

class _UserState extends State<UserDetails> {
  String? id, wallet;
  int total = 0, amount2 = 0;

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      amount2 = total;
      setState(() {});
    });
  }

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    UserStream = await DatabaseMethods().getUserDetails();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? UserStream;

  Widget _buildAvatarPlaceholder(String name) {
    return Container(
      height: 160,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.blue, // Placeholder background color
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '', // Get the first character of the name
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget UserCart() {
    return StreamBuilder(
      stream: UserStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];

                  return Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                    child: Material(
                      elevation: 5.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildAvatarPlaceholder(ds["Name"]), // Use the custom widget for avatar
                            SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: " + ds["Name"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Email: " + ds["Email"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Id: " + ds["Id"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Wallet: " + ds["Wallet"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Text(
                    "All User Details",
                    style: AppWidget.HeadlineTextFieldStyle(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: UserCart(),
            ),
          ],
        ),
      ),
    );
  }
}
