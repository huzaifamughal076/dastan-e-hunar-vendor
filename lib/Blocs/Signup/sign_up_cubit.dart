import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../Utils/utils.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void signUpUser(
    BuildContext context,
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
    emit(const SignUpState(loading: true));
    await Authentication.signUp(
      email,
      password,
      firstName,
      lastName,
      shopName,
      shopType,
      shopLocation,
      shopDescription,
      bankName,
      accountNumber,
    ).then((result) {
      if (result == null) {
        emit(const SignUpState(loading: false));
        Navigator.pop(context);
        return SnackBarService.showSnackBar(context,
            title: "Congratulations!",
            message: "Your shop was successfully created",
            contentType: ContentType.success);
      }
      return emit(SignUpState(error: result));
    });
  }
}
