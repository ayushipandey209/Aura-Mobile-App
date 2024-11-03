import 'dart:async';

import 'package:aura/service/database.dart';
import 'package:aura/service/shared_pref.dart';
import 'package:aura/widget/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderState();
}

class _OrderState extends State<OrderDetails> {
String? id, wallet;
int total=0, amount2=0;

void startTimer(){
  Timer(Duration(seconds: 3), () { 
    amount2=total;
    setState(() {
      
    });
  });
}

getthesharedpref()async{
id= await SharedPreferenceHelper().getUserId();
wallet= await SharedPreferenceHelper().getUserWallet();
setState(() {
  
});
}

ontheload()async{
await getthesharedpref();
OrderStream= await DatabaseMethods().getItemOrder(id!);
setState(() {
  
});
}

@override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? OrderStream;

  Widget OrderCart() {
  return StreamBuilder(
    stream: OrderStream,
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
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              ds["Image"],
                              height: 160,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: " + ds["Name"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, // Making the text bold
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Quantity: " + ds["Quantity"].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, // Making the text bold
                                    fontSize: 14, // Adjust font size as needed
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Total Price: \₹" + ds["Total"].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, // Making the text bold
                                    fontSize: 14, // Adjust font size as needed
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 200), // Adjust the maxWidth as needed
                                  child: Text(
                                    "Address: " + ds["Address"], // Accessing the "Address" field directly
                                    style: TextStyle(
                                      fontSize: 14, // Adjust font size as needed
                                       fontWeight: FontWeight.bold, // Making the text bold
                                 
                                    ),
                                    overflow: TextOverflow.ellipsis, // Optionally handle overflow with ellipsis
                                    maxLines: 2, // Optionally limit the maximum number of lines
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
                      "Order Cart",
                      style: AppWidget.HeadlineTextFieldStyle(),
                    )))),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.3,
              child: OrderCart()),
           
           
            
          ],
        ),
      ),
    );
  }
}