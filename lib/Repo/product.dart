import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../Utils/utils.dart';

class ProductService {
  static Future<String?> addProduct(
      String uid,
      String productName,
      String productDescription,
      List<String> productImages,
      String productPrice) async {
    try {
      await FirebaseFirestore.instance
          .collection("shops")
          .doc(uid)
          .collection("products")
          .doc()
          .set(
        {
          "productName": productName,
          "productDescription": productDescription,
          "productImage": productImages,
          "productPrice": productPrice,
        },
      );
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<List<String>> uploadImages(
      String uid, List<File> productImages) async {
    final List<String> images = [];
    for (var element in productImages) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child(uid)
          .child("products")
          .child(basename(element.path));
      final uploadTask = storageRef.putFile(File(element.path));
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      if (snapshot.state == TaskState.success) {
        final String downloadURL = await snapshot.ref.getDownloadURL();
        images.add(downloadURL);
      }
    }
    return images;
  }


}
