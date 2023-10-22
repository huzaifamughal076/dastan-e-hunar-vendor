import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static Future<String?> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
    String shopName,
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

      // Create a user document in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': firstName,
        'email': email,
        'uid': userCredential.user!.uid,
        'lastName': lastName,
        'shopName': shopName,
        'shopDescription': shopDescription,
        'bankName': bankName,
        'accountNumber': accountNumber,
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
