

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Utils/utils.dart';

class VendorAccountStatusServices{

  static Future<void> getAccountStatus(BuildContext context, String? id)async{
    FirebaseFirestore.instance.collection('users').doc(id).snapshots().listen((event) {
      String? accountStatus =  event.data()?['accountStatus'];
      if(accountStatus?.toLowerCase()=="blocked"){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage(),), (route) => false);
        SnackBarService.showSnackBar(context, title: "Alert", message: "Your account has been banned from admin.", contentType: ContentType.failure);
        // Navigator.popAndPushNamed(context, AppRoutes.login,);
      }

     });

  }
}