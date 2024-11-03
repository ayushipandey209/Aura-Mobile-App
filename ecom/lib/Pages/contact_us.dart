
import 'package:aura/service/color.dart';
import 'package:aura/service/config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Us Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContactUsPage(),
    );
  }
}

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        
      ),
      
      body: Padding(
        
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 130,
                child: Lottie.asset(
                  'images/contactus.json',
                ),
              ),
            ),
            // Company Logo
            Text(
              'AURA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
"Aura : Empowering Women Together Join a vibrant community of support,inspiration, and empowerment. Connect, grow, and thrive with Aura.",   textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                makePhoneCall("9730022471");
              },
              icon: Icon(Icons.phone, size: 30, color: Colors.white),
              label: Text(
                'Phone',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: button,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                mailto("ayushipandey20903@gmail.com");
              },
              icon: Icon(Icons.email, size: 30, color: Colors.white),
              label: Text(
                'Email',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: button,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
            SizedBox(height: 20),
            // Lottie animation
          ],
        ),
      ),
    );
  }
}
