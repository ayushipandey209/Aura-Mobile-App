
// ignore_for_file: unused_field, unnecessary_import

import 'package:aura/Pages/details.dart';
import 'package:aura/service/color.dart';
import 'package:aura/service/database.dart';
import 'package:aura/service/shared_pref.dart';
import 'package:aura/widget/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    String? profile, name, email;
  bool clothing = false;
bool bags = false;
bool makeup = false;
bool shoes = false;

     String? _currentAddress;
  Position? _currentPosition;
  late String latitude;
  late String longitude;
  late String address;
  bool isloading = true;
  bool isloadinglocation = true;
Stream? itemStream;
ontheload() async{
  itemStream = await DatabaseMethods().getItem("Clothing");
  setState(() {
    
  });

}
 getthesharedpref() async {
    profile = await SharedPreferenceHelper().getUserProfile();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }
    onthisload() async {
    await getthesharedpref();
    setState(() {});
  }
@override
  void initState() {
  
    super.initState();
    ontheload();
    onthisload();
    _getCurrentPosition();
  }
//location
Future<void> _getCurrentPosition() async {
    final bool hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromPosition(position);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
      
        isloadinglocation = false;
        _currentAddress = place.subLocality.toString();
           prefs.setString('location', _currentAddress.toString());
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }


Widget allItems() {
   return StreamBuilder( stream : itemStream, builder : (context , AsyncSnapshot snapshot)
   {
      return snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context , index)
      {
DocumentSnapshot ds = snapshot.data.docs[index];
return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"],)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      
                    child: Material(
                       borderRadius :BorderRadius.circular(20),
                      elevation: 17.0,
                      child: Container(
                       
                        padding: EdgeInsets.all(11),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                      
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(ds["Image"], height: 150 , width: 150, fit: BoxFit.fill,)),
                          Text(ds["Name"] , style: AppWidget.boldTextFieldStyle(),),
                                 Row(
                                   children: [
                                     Text("Hot & New " , style: TextStyle(fontSize: 14 , color: Color.fromARGB(255, 253, 130, 130)),),
                                     Icon(Icons.flash_on_rounded , size: 19, color: const Color.fromARGB(255, 196, 25, 13),)
                                   ],
                                 ),
                                 Text("Rs " +ds["Price"] , style: AppWidget.SemiBoldTextFieldStyle())
                        ],),
                      ),
                    ),
                  ),
                ),
              );
      }): CircularProgressIndicator();
   });
}
//vertical items
Widget allItemsVertically() {
   return StreamBuilder( stream : itemStream, builder : (context , AsyncSnapshot snapshot)
   {
      return snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length-2,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index)
      {
DocumentSnapshot ds = snapshot.data.docs[index+2];
return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"],)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Container(
                 
                      child: Material(
                                        borderRadius :BorderRadius.circular(20),
                        elevation: 17.0,
                          child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(ds["Image"] , height: 120 , width: 120, fit: BoxFit.fill,)),
                    SizedBox(width: 20.0,),
                  Column(
  children: [
    Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ds["Name"], style: AppWidget.SemiBoldTextFieldStyle()),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: -5,
          child: Container(
            padding: EdgeInsets.only(top: 1 , right: 6 , left: 2),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 15, 121, 207), // Adjust the color as needed
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(11),
              ),
            ),
            child: Text(
              "Top Deals",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
    Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Top Deals", style: AppWidget.LightTextFieldStyle()),
          ],
        ),
      ),
    ),
    Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("₹ "+ds["Price"], style: AppWidget.SemiBoldTextFieldStyle()),
          ],
        ),
      ),
    ),
  ],
),


                                  ],),
                                ),
                           
                      ),
                    
                  ),
                ),
              );
      }): CircularProgressIndicator();
   });
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only( top: 50,left: 20 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [  
              Text( "ᗩᑌᖇᗩ", style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 25 , color: Color.fromARGB(255, 145, 5, 52))),
              Container(
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Container(
                 margin: EdgeInsets.only(top: 10),
                  height: 50,
                  child: Column(
                    children: [
                                Icon(
                                  size: 25,
                  Icons.location_on,
                  color: button,
                                ),
                          
                          Container(
                            child: Text(
                              _currentAddress ?? '', 
                              style: TextStyle(fontSize: 12, color: button),
                            ),
                          )
                              ],
                  ),
                ),
              )
            ],
          ),
            Text(
            "Discover and get you deal",
           style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 16 , color: Color.fromARGB(255, 196, 23, 81)) ,
          ),
          Divider(),
          SizedBox(height: 5,),
          Container( margin: EdgeInsets.only(right: 10),   child: showItem()),
          SizedBox(height: 20),
          Container(
            height: 275,
            child: allItems()),
        
          Text("View More Products" , style: TextStyle(fontFamily: "POPPINS" , fontSize: 15)),
           Container(
            height: 290,
            child: allItemsVertically()),
        ],),),
        
      ),
       
    );
   
  }


Widget showItem() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () async{
            clothing = true;
            bags = false;
            makeup = false;
            shoes = false;
            itemStream = await DatabaseMethods().getItem("Clothing");

          setState(() {
          
          });
        },
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: clothing ? catcolor: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "images/clothing.png",
              height: 50,
              width: 50,
              fit: BoxFit.fill,
             
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () async{
              itemStream = await DatabaseMethods().getItem("Bags");
          setState(() {
            clothing = false;
            bags = true;
            makeup = false;
            shoes = false;
          });
        },
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: bags ? catcolor : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "images/bags.jpg",
              height: 50,
              width: 50,
              fit: BoxFit.fill,
       
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () async{
             clothing = false;
            bags = false;
            makeup = true;
            shoes = false;
              itemStream = await DatabaseMethods().getItem("Makeup");
          setState(() {
         
          });
        },
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: makeup ? catcolor : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "images/makeup.png",
              height: 50,
              width: 50,
              fit: BoxFit.fill,
       
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () async {
          clothing = false;
            bags = false;
            makeup = false;
            shoes = true;
            itemStream = await DatabaseMethods().getItem("Shoes"); 
          setState(() {
            
          });
        },
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: shoes ? catcolor : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "images/shoes.png",
              height: 50,
              width: 50,
              fit: BoxFit.fill,
             
            ),
          ),
        ),
      ),
    ],
  );
}

}

