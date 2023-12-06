import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Authentication {
  static Future<String?> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
    String shopName,
    String shopType,
    String shopLocation,
    String shopDescription,
    String bankName,
    String accountNumber,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? token = await FirebaseMessaging.instance.getToken();

      // Create a user document in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': firstName,
        'email': email,
        'profileUrl':'',
        'uid': userCredential.user!.uid,
        'lastName': lastName,
        'shopName': shopName,
        'shopType': shopType,
        'shopLocation': shopLocation,
        'shopDescription': shopDescription,
        'bankName': bankName,
        'accountNumber': accountNumber,
        'role':'vendor',
        'invoiceUrl':'',
        'accountStatus':'unActive',
        'token':'$token'
      });
      await FirebaseFirestore.instance
          .collection('shops')
          .doc(userCredential.user!.uid)
          .set({
        'shopName': shopName,
        'shopDescription': shopDescription,
      });

      return null; // Return null if sign-up is successful
    } catch (error) {
      return error.toString(); // Return the error message if sign-up fails
    }
  }
}
