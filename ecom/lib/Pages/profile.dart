// import 'dart:io';
// import 'dart:typed_data';

// import 'package:aura/Pages/contact_us.dart';
// import 'package:aura/Pages/orderdetails.dart';
// import 'package:aura/Pages/signup.dart';
// import 'package:aura/service/auth.dart';
// import 'package:aura/service/color.dart';
// import 'package:aura/service/shared_pref.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:random_string/random_string.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Profile extends StatefulWidget {
//   const Profile({super.key});

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   String? profile, name, email;
//   final ImagePicker _picker = ImagePicker();
//   File? selectedImage;
//    Uint8List? _image;
 

//   Future getImage() async {
//     var image = await _picker.pickImage(source: ImageSource.gallery);

//     selectedImage = File(image!.path);
//     setState(() {
//       uploadItem();
//     });
//   }
//      Future<void> _saveImage(File image) async {
//     Directory appDir = await getApplicationDocumentsDirectory();
//     String imagePath = '${appDir.path}/profile_image.jpg';
//     File(imagePath).writeAsBytesSync(image.readAsBytesSync());
//   }

//   Future<void> _deleteImage() async {
//     Directory appDir = await getApplicationDocumentsDirectory();
//     File imageFile = File('${appDir.path}/profile_image.jpg');
//     if (await imageFile.exists()) {
//       await imageFile.delete();
//     }
//   }
//    Future<void> _loadImage() async {
//     Directory appDir = await getApplicationDocumentsDirectory();
//     File imageFile = File('${appDir.path}/profile_image.jpg');
//     if (await imageFile.exists()) {
//       setState(() {
//         _image = imageFile.readAsBytesSync();
//       });
//     }
//   }

//   uploadItem() async {
//     if (selectedImage != null) {
//       String addId = randomAlphaNumeric(10);

//       Reference firebaseStorageRef =
//           FirebaseStorage.instance.ref().child("blogImages").child(addId);
//       final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

//       var downloadUrl = await (await task).ref.getDownloadURL();
//       await SharedPreferenceHelper().saveUserProfile(downloadUrl);
//       setState(() {
        
//       });
//     }
//   }

//   getthesharedpref() async {
//     profile = await SharedPreferenceHelper().getUserProfile();
//     name = await SharedPreferenceHelper().getUserName();
//     email = await SharedPreferenceHelper().getUserEmail();
//     setState(() {});
//   }

  
//   @override
//   void initState() {
//     onthisload();
//     super.initState();
//   }
//  onthisload() async {
//     await getthesharedpref();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: name == null
//         ? CircularProgressIndicator() // Display circular indicator if name is null
//         : SingleChildScrollView(
//           child: Container(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
//                     height: MediaQuery.of(context).size.height / 4.3,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         color: button,
//                         borderRadius: BorderRadius.vertical(
//                             bottom: Radius.elliptical(
//                                 MediaQuery.of(context).size.width, 105.0))),
//                   ),
//                   Center(
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           top: MediaQuery.of(context).size.height / 6.5),
//                       child: Material(
//                         elevation: 10.0,
//                         borderRadius: BorderRadius.circular(60),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(60),
//                           child: selectedImage==null?  GestureDetector(
//                             onTap: (){
//                               getImage();
//                             },
                            
//                     child: Stack(
//                       children: [
//                        _image != null
//             ? CircleAvatar(radius: 60, backgroundImage: MemoryImage(_image!))
//             : const CircleAvatar(
//                 radius: 60,
//                 backgroundImage: NetworkImage(
//             "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
//               )
//           ,
//                         Positioned(
//                           bottom: -0,
//                           left: 120,
//                           child: IconButton(
//                             onPressed: () {
//                               showImagePickerOption(context);
//                             },
//                             icon: const Icon(Icons.add_a_photo, color: Color.fromARGB(255, 75, 32, 32)),
//                           ),
//                         )
//                       ],
//                     ),
                  
//                           ): Image.file(selectedImage!,  height: 120,
//                               width: 120,
//                               fit: BoxFit.cover,),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 70.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                          name?? ' ',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 23.0,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Poppins'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Material(
//                   borderRadius: BorderRadius.circular(10),
//                   elevation: 2.0,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       vertical: 15.0,
//                       horizontal: 10.0,
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.person,
//                           color: Colors.black,
//                         ),
//                         SizedBox(
//                           width: 20.0,
//                         ),
//                         Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Name",
//                 style: TextStyle(
//             color: Colors.black,
//             fontSize: 16.0,
//             fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 5), 
//              Text(
//               name ?? ' ',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.w600),
//             )
//             ],
//           )
          
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.0,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Material(
//                   borderRadius: BorderRadius.circular(10),
//                   elevation: 2.0,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       vertical: 15.0,
//                       horizontal: 10.0,
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.email,
//                           color: Colors.black,
//                         ),
//                         SizedBox(
//                           width: 20.0,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Email",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                             Text(
//                              email!,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w600),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.0,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Material(
//                   borderRadius: BorderRadius.circular(10),
//                   elevation: 2.0,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       vertical: 15.0,
//                       horizontal: 10.0,
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.headset_mic_rounded,
//                           color: Colors.black,
//                         ),
//                         SizedBox(
//                           width: 20.0,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
//                               },
//                               child: Text(
//                                 "Contact Us",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             )
//                           ],
//                         ),
                        
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.0,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Material(
//                   borderRadius: BorderRadius.circular(10),
//                   elevation: 2.0,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       vertical: 15.0,
//                       horizontal: 10.0,
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.shopping_bag,
//                           color: Colors.black,
//                         ),
//                         SizedBox(
//                           width: 20.0,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails()));
//                               },
//                               child: Text(
//                                 "Order Details",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             )
//                           ],
//                         ),
                        
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.0,
//               ),
//               GestureDetector(
//                 onTap: (){
//                 showDeleteAccountDialog(context);
//                 },
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Material(
//                     borderRadius: BorderRadius.circular(10),
//                     elevation: 2.0,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         vertical: 15.0,
//                         horizontal: 10.0,
//                       ),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.delete,
//                             color: Colors.black,
//                           ),
//                           SizedBox(
//                             width: 20.0,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Delete Account",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.0,
//               ),
//               GestureDetector(
//                 onTap: (){
            
//                  showLogoutAccountDialog(context);
//                 },
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Material(
//                     borderRadius: BorderRadius.circular(10),
//                     elevation: 2.0,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         vertical: 15.0,
//                         horizontal: 10.0,
//                       ),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.logout,
//                             color: Colors.black,
//                           ),
//                           SizedBox(
//                             width: 20.0,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "LogOut",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//                 ),
//         ),
//     );
//   }
// void showLogoutAccountDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Are you sure you want to Logout?'),
//         actions: [
//           TextButton(
//             onPressed: () async{
//               SharedPreferences prefs = await SharedPreferences.getInstance();
//                   AuthMethods().SignOut();
//              prefs.setBool("isLogin",false);
//                 Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => SignUp()));
//             },
//             child: Text('Yes'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
            
//             },
//             child: Text('No'),
//           ),
//         ],
//       );
//     },
//   );
// }

//  void showImagePickerOption(BuildContext context) {
//     showModalBottomSheet(
//       backgroundColor: Colors.blue[100],
//       context: context,
//       builder: (builder) {
//         return Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 4.5,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       _pickImageFromGallery();
//                     },
//                     child: const SizedBox(
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.image,
//                             size: 70,
//                           ),
//                           Text("Gallery")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       _pickImageFromCamera();
//                     },
//                     child: const SizedBox(
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.camera_alt,
//                             size: 70,
//                           ),
//                           Text("Camera")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   void _pickImageFromGallery() async {
//     final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (returnImage == null) return;
//     setState(() {
//       selectedImage = File(returnImage.path);
//       _image = File(returnImage.path).readAsBytesSync();
//     });
//     _saveImage(selectedImage!); // Save the selected image
//     Navigator.of(context).pop(); // Close the model sheet
//   }

//   void _pickImageFromCamera() async {
//     final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
//     if (returnImage == null) return;
//     setState(() {
//       selectedImage = File(returnImage.path);
//       _image = File(returnImage.path).readAsBytesSync();
//     });
//     _saveImage(selectedImage!); // Save the selected image
//     Navigator.of(context).pop(); // Close the model sheet
//   }
// }


// void showDeleteAccountDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Are you sure you want to delete your account?'),
//         actions: [
//           TextButton(
//             onPressed: () async{
//               AuthMethods().deleteuser();
//               Navigator.of(context).pop();
//                  SharedPreferences prefs = await SharedPreferences.getInstance();
//            prefs.setBool("isLogin",false);
//                 Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => SignUp()));
//             },
//             child: Text('Yes'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
            
//             },
//             child: Text('No'),
//           ),
//         ],
//       );
//     },
//   );
// }



  import 'dart:io';

import 'package:aura/Pages/contact_us.dart';
import 'package:aura/Pages/orderdetails.dart';
import 'package:aura/Pages/signup.dart';
import 'package:aura/service/auth.dart';
import 'package:aura/service/color.dart';
import 'package:aura/service/shared_pref.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
    setState(() {
      uploadItem();
    });
  }

  uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();
      await SharedPreferenceHelper().saveUserProfile(downloadUrl);
      setState(() {
        
      });
    }
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
    onthisload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: name==null? CircularProgressIndicator(): Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                    height: MediaQuery.of(context).size.height / 4.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: button,
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                MediaQuery.of(context).size.width, 105.0))),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 6.5),
                      child: Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(60),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: selectedImage==null?  GestureDetector(
                            onTap: (){
                              getImage();
                            },
                            child: profile==null? Image.asset("images/boy.jpg", height: 120, width: 120, fit: BoxFit.cover,) :Image.network(
                            profile!,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ): Image.file(selectedImage!,  height: 120,
                              width: 120,
                              fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 70.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              name!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                             email!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 30.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.headset_mic_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
                                },
                                child: Text(
                                  "Contact Us",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails()));
                                },
                                child: Text(
                                  "Order Details",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: ()async{
                  AuthMethods().deleteuser();
                  showDeleteAccountDialog(context);
                 
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delete Account",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: ()async{
                  AuthMethods().SignOut();
                     showLogoutAccountDialog(context);
                 
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "LogOut",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


void showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure you want to delete your account?'),
        actions: [
          TextButton(
            onPressed: () async{
              AuthMethods().deleteuser();
              Navigator.of(context).pop();
                 SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setBool("isLogin",false);
                Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
}


void showLogoutAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure you want to Logout?'),
        actions: [
          TextButton(
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
                  AuthMethods().SignOut();
             prefs.setBool("isLogin",false);
                Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
}
