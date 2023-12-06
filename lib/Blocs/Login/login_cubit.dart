import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Repo/registration_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../Utils/utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LoginCubit() : super(const LoginState());

  clearData() async {
    emit(const LoginState());
  }

  setUserData(Map<String, dynamic>? data){
    emit(state.copyWith(userData: data, requestStatus: RequestStatus.initial));
  }

  Future<void> login(String email, String password) async {
    emit(const LoginState(requestStatus: RequestStatus.loading));
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String uid = userCredential.user?.uid ?? '';
      final userData = await getUserData(uid);

      if (userData != null) {
        emit(LoginState(
            requestStatus: RequestStatus.success, userData: userData));
        // You can emit the user data here for consumption in UI
      } else {
        emit(const LoginState(requestStatus: RequestStatus.failure));
      }
    } catch (error) {
      emit(const LoginState(requestStatus: RequestStatus.failure));
    }
  }

  Future<void> sendRegistrationRequest(BuildContext context,String? userId, File? file) async {
    
    emit(const LoginState(requestStatus: RequestStatus.loading));
    Map<String,dynamic>? oldData= context.read<LoginCubit>().state.userData;
    try {
      await RegistrationServices.sendRegistrationRequest(context, userId,file)
          .then((value) async {
        if (value) {
          Navigator.pop(context);
SnackBarService.showSnackBar(context,
                                title: "Registeration request sent Successfully",
                                message:
                                    "Please sit back and relax while we confirm your request.",
                                contentType: ContentType.success);
          final userData = await getUserData(userId??"");
          
          if (userData != null) {
            emit(LoginState(
                requestStatus: RequestStatus.initial, userData: userData));
            // You can emit the user data here for consumption in UI
          } else {
            emit( LoginState(requestStatus: RequestStatus.failure,userData: oldData));
          }
        }else{
          emit( LoginState(requestStatus: RequestStatus.failure,userData: oldData));
        }
      });
    } catch (error) {
      emit( LoginState(requestStatus: RequestStatus.failure,userData: oldData));
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
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
