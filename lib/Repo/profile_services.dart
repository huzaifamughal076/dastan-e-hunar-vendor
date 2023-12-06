import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Blocs/Profile%20Cubit/cubit/profile_cubit.dart';
import 'package:dashtanehunar/Repo/registration_services.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';


class ProfileSevices {
  static Future<void> updateProfile(BuildContext context) async {
    final uid = context.read<LoginCubit>().state.userData?['uid'];
    final firstName = context.read<ProfileCubit>().state.firstName;
    final lastName = context.read<ProfileCubit>().state.lastName;
    final profilePicture = context.read<ProfileCubit>().state.profilePicture;

    try {
      if (profilePicture?.path.isEmpty ?? true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({"firstName": "$firstName", "lastName": "$lastName"}).then(
                (value) async {
          await getUserData(uid).then((value) {
            context.read<LoginCubit>().setUserData(value);
            Navigator.pop(context);
            SnackBarService.showSnackBar(context,
                                title: "Profile Updated Successfully",
                                message:
                                    "World is under you knees when you are powerful",
                                contentType: ContentType.success);
          });
        });
      } else {
        await RegistrationServices.uploadImages(uid, profilePicture)
            .then((value) async {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            "firstName": "$firstName",
            "lastName": "$lastName",
            "profileUrl": "$value"
          }).then((value) async {
            await getUserData(uid).then((value) {
              context.read<LoginCubit>().setUserData(value);
              Navigator.pop(context);
              SnackBarService.showSnackBar(context,
                                title: "Profile Updated Successfully",
                                message:
                                    "World is under you knees when you are powerful",
                                contentType: ContentType.success);
            });
          });
        });
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
  }

   static Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return null; // User document doesn't exist
      }
    } catch (error) {
      return null;
    }
  }
}
