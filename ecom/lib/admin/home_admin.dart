import 'package:aura/admin/add_items.dart';
import 'package:aura/admin/user_details.dart';
import 'package:aura/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(child: Text("Aura Admin", style: AppWidget.HeadlineTextFieldStyle(),),),
            Divider(),
            SizedBox(height: 50.0,),
            GestureDetector(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAura()));
              },
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                    child: Column(
                      children: [
                        Material(
                          elevation: 10,
                          child: Row(children: [
                            Padding(padding: EdgeInsets.all(6.0),
                            child: Image.asset("images/applogo.png", height: 120, width: 120, fit: BoxFit.fill,),),
                                            SizedBox(width: 30.0,) ,
                                            Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.pink,
                          child: Text("Add Items", style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),)) ],),
                        ),
                      
                      ],
                    ),
                  ),
                ),
              ),
            ),
              SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> UserDetails()));
                        },
                        child: Material(
                          elevation: 10,
                          child: Row(children: [
                              Padding(padding: EdgeInsets.all(6.0),
                              child: Image.asset("images/applogo.png", height: 120, width: 120, fit: BoxFit.fill,),),
                                              SizedBox(width: 30.0,) ,
                                              Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.pink,
                            child: Text("All User Details", style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),)) ],),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}