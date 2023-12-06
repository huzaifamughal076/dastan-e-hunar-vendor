import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';


class RegistrationServices {
  static Future<bool> sendRegistrationRequest(
      BuildContext context,String? userId, File? image) async {
       
    try {
      await uploadImages(userId??"", image).then((value)async{
 await FirebaseFirestore.instance
          .collection('users')
          .doc(userId??"")
          .update({"accountStatus": "pending","invoiceUrl":value??""});
      });

      return true;
    } catch (e) {
      debugPrint(e.toString());
      
      return false;
    }
  }

    static Future <String?> uploadImages(
      String uid, File? productImages) async {
     String? image;
      try{
final storageRef = FirebaseStorage.instance
          .ref()
          .child(uid)
          .child(basename(productImages?.path??""));
      final uploadTask = storageRef.putFile(File(productImages?.path??""));
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      if (snapshot.state == TaskState.success) {
        final String downloadURL = await snapshot.ref.getDownloadURL();
        image = downloadURL;
      }
      } on FirebaseException catch(e){
        debugPrint(e.message);
      }
    
    return image;
  }
}
