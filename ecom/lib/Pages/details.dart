

import 'package:aura/Pages/confirmorder.dart';
import 'package:aura/service/color.dart';
import 'package:aura/service/database.dart';
import 'package:aura/service/shared_pref.dart';
import 'package:aura/widget/widget_support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Details extends StatefulWidget {
  String image, name, detail, price;
  Details(
      {required this.detail,
      required this.image,
      required this.name,
      required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1, total = 0;
  String? id;

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
    total = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                )),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: 
               Material(
                elevation: 9,
                 child: Image.network(
                    widget.image,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    fit: BoxFit.fill,
                  ),
               ),
              
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontFamily: "POPPINS",
                        fontSize: 19
                      ),
                    ),
                     
                  ],
                  
                ),
                  
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                      total = total - int.parse(widget.price);
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: button,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  a.toString(),
                  style: AppWidget.SemiBoldTextFieldStyle(),
                ),
                SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    ++a;
                    total = total + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color:button,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
           
                SizedBox(
              height: 10.0,
            ),
                      Text("Product Details" , style:  AppWidget.smalltextfield()),
                       SizedBox(
              height: 10.0,
            ),
            
           SizedBox(
  height: 200,
  child: SingleChildScrollView(
    child: Container(
      child: Text(
        widget.detail,
        style: AppWidget.SemiBoldTextFieldStyle(),
      ),
    ),
  ),
),

            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total",
                        style: AppWidget.SemiBoldTextFieldStyle(),
                      ),
                      Text(
                        "\₹" + total.toString(),
                        style: AppWidget.SemiBoldTextFieldStyle(),
                      )
                    ],
                  ),
                   SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmOrder(productName: widget.name, quantity: a , productImage: widget.image, totalPrice: total,)));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 5.8,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Icon(
                                    Icons.shopping_bag,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addtoCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image
                      };
                      await DatabaseMethods().addtoCart(addtoCart, id!);
                              showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.pink[200],
      title: Text('Item Added to Cart' , style: AppWidget.ConfirmText()),
      content: Text(
        'You can view in cart',
        style: TextStyle(fontSize: 18.0 , color: Colors.white) ,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  },
);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5.8,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 234, 125, 48),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              
                               Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                        ),
                       
                      ],
                    ),
                  )
                ],
                
              ),
            )
          ],
        ),
      ),
    );
  }
}