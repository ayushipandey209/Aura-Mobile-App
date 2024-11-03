import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseMethods
{
  Future addUserDetail(Map<String , dynamic> userInfoMap , String id)async
  {
   return await FirebaseFirestore.instance.collection('users').doc(id).set(userInfoMap);

  }
UpdateUserwallet(String id , String amount)async
{
  return await FirebaseFirestore.instance.collection("users").doc(id).update({"Wallet" : amount});
}

Future addAuraItem(Map<String , dynamic> userInfoMap , String name)async
  {
   return await FirebaseFirestore.instance.collection(name).add(userInfoMap);

  }

  Future <Stream<QuerySnapshot>> getItem(String name)async
  {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

//add to cart
  Future addtoCart(Map<String , dynamic> userInfoMap , String id)async
  {
   return await FirebaseFirestore.instance
   .collection("users").
   doc(id)
   .collection("Cart")
   .add(userInfoMap);

  }

//order
//add to cart
  Future addtoOrder(Map<String , dynamic> userInfoMap , String id)async
  {
   return await FirebaseFirestore.instance
   .collection("users").
   doc(id)
   .collection("Order")
   .add(userInfoMap);

  }
  
  Future <Stream<QuerySnapshot>> getItemCart(String id)async
  {
    return await FirebaseFirestore.instance.collection("users")
    .doc(id).
    collection("Cart")
    .snapshots();
  }
//fetch order
  Future <Stream<QuerySnapshot>> getItemOrder(String id)async
  {
    return await FirebaseFirestore.instance.collection("users")
    .doc(id).
    collection("Order")
    .snapshots();
  }



  Future<void> deleteCartItems(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('Cart')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
    } catch (e) {
      print("Error deleting cart items: $e");
      throw e;
    }
  }



//get user details
 Future <Stream<QuerySnapshot>> getUserDetails()async
  {
    return await FirebaseFirestore.instance.collection("users")
    .snapshots();
  }

}

