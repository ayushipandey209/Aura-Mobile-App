import 'dart:async';

import 'package:aura/Pages/bottomnav.dart';
import 'package:aura/service/database.dart';
import 'package:aura/service/shared_pref.dart';
import 'package:aura/widget/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
String? id, wallet;
int total=0, amount2=0;

void startTimer(){
  Timer(Duration(seconds: 1), () { 
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
ItemStream= await DatabaseMethods().getItemCart(id!);
setState(() {
  
});
}

@override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? ItemStream;

  Widget foodCart() {
    return StreamBuilder(
        stream: ItemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    total= total+ int.parse(ds["Total"]);
                    
                    return Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                height: 90,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(child: Text(ds["Quantity"])),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                children: [
                                  Text(
                                    ds["Name"],
                                    style: AppWidget.SemiBoldTextFieldStyle(),
                                  ),
                                  Text(
                                  "\₹"+ ds["Total"],
                                    style: AppWidget.SemiBoldTextFieldStyle(),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                  elevation: 2.0,
                  child: Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart),SizedBox(width: 10,),
                              Text(
                                                    "Your Cart",
                                                    style: AppWidget.HeadlineTextFieldStyle(),
                                                  ),
                            ],
                          )))),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height/1.7,
                child: foodCart()),
            
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Price",
                      style: AppWidget.boldTextFieldStyle(),
                    ),
                    Text(
                 "\₹"+ total.toString(),
                      style: AppWidget.SemiBoldTextFieldStyle(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: ()async{
        int currentAmount = int.parse(wallet!);
                  int deductionAmount = total;
                  void showSnackbar(String message) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        message,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ));
                  }
        
                  if (currentAmount >= deductionAmount) {
                    await DatabaseMethods().deleteCartItems(id!);
                    int newAmount = currentAmount - deductionAmount;
                    await DatabaseMethods().UpdateUserwallet(id!, newAmount.toString());
                    await SharedPreferenceHelper().saveUserWallet(newAmount.toString());
        
                    total = 0;
                    setState(() {});
        
                    // Show success message
                    showSnackbar(
                      
                      'Amount Deducted!');
                      //data added to database
                      
                       
                           showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
        backgroundColor: Colors.green,
        title: Text('Order Confirmation' , style: AppWidget.ConfirmText()),
        content: Text(
          'Your order has been confirmed.',
          style: TextStyle(fontSize: 18.0 , color: Colors.white) ,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav()));
            },
            child: Text('OK'),
          ),
        ],
            );
          },
        );
                  } else {
                    showSnackbar('Insufficient balance in the wallet');
                  }
         
           
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: MediaQuery.of(context).size.width,
               
                  decoration: BoxDecoration(
                      color: Colors.green, borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Center(
                      child: Text(
                    "Order All",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
