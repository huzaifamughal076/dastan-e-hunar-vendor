part of 'login_cubit.dart';

enum RequestStatus { initial, loading, success, failure }

class LoginState {
  final Map<String, dynamic>? userData;
  final RequestStatus requestStatus;
  const LoginState({this.userData, this.requestStatus = RequestStatus.initial});
}
