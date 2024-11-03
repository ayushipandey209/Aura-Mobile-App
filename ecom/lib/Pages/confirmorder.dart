import 'package:aura/Pages/bottomnav.dart';
import 'package:aura/Pages/home.dart';
import 'package:aura/service/database.dart';
import 'package:aura/service/shared_pref.dart';
import 'package:aura/widget/widget_support.dart';
import 'package:flutter/material.dart';

class ConfirmOrder extends StatefulWidget {
  final String productName;
  final String productImage;
  final int totalPrice;
  final int quantity;

  const ConfirmOrder({
    required this.productName,
    required this.quantity,
    required this.productImage,
    required this.totalPrice,
  });

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}
  int? total; // Initialize total as nullable

String? name;
  String? id;
String? address;
String? wallet;

class _ConfirmOrderState extends State<ConfirmOrder> {
  TextEditingController addressController = TextEditingController();

  getSharedPref() async {
      id = await SharedPreferenceHelper().getUserId();
    name = await SharedPreferenceHelper().getUserName();
    wallet = await SharedPreferenceHelper().getUserWallet();

    setState(() {});
  }

  onLoad() async {
    await getSharedPref();
    setState(() {});
  }

  @override
  void initState() {
    onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with border
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Add border here
                ),
                child: Image.network(
                  widget.productImage,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                ),
              ),
              SizedBox(height: 16),
              // Product Details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Product Details Heading (Left)
                  Expanded(
                    child: Text(
                      'Product Name:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Product Details Data (Right)
                  Expanded(
                    child: Text(
                      '${widget.productName}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Quantity:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${widget.quantity}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Total Price:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${widget.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Name:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${name}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Address TextField
              TextFormField(
  controller: addressController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    } else if (value.length <= 10) {
      return 'Address must be longer than 10 characters';
    }
    return null;
  },
  decoration: InputDecoration(
    labelText: 'Enter your address',
    border: OutlineInputBorder(),
  ),
),

              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                
                 ElevatedButton(
                
  onPressed: ()    async {

                int currentAmount = int.parse(wallet!);
                int deductionAmount = widget.totalPrice;
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
                 
                  int newAmount = currentAmount - deductionAmount;
                  await DatabaseMethods().UpdateUserwallet(id!, newAmount.toString());
                  await SharedPreferenceHelper().saveUserWallet(newAmount.toString());

                  total = 0;
                  setState(() {});

                  // Show success message
                  showSnackbar(
                    
                    'Amount Deducted!');
                    //data added to database
                      Map<String, dynamic> addtoOrder = {
                        "Name": widget.productName,
                        "Quantity": widget.quantity,
                        "Total": widget.totalPrice,
                        "Image": widget.productImage,
                        "Address" : addressController.text,
                      };
                      await DatabaseMethods().addtoOrder(addtoOrder, id!);
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
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green, // Background color
    foregroundColor: Colors.white, // Text color
    maximumSize: Size.fromHeight(100), // Button width and height
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Button border radius
    ),
  ),
  child: Text(
    'Confirm',
    style: TextStyle(
      fontSize: 18, // Font size
    ),
  ),
),

                  // Cancel Button
                ElevatedButton(
  onPressed: () {
    Navigator.pop(context);
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red, // Background color
    foregroundColor: Colors.white, // Text color
    maximumSize: Size.fromHeight(100), // Button width and height
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Button border radius
    ),
  ),
  child: Text(
    'Cancel',
    style: TextStyle(
      fontSize: 18, // Font size
    ),
  ),
),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
