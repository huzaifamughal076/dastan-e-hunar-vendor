import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Utils/utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LoginCubit() : super(const LoginState());

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
