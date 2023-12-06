import 'package:dashtanehunar/Repo/profile_services.dart';
import 'package:dashtanehunar/Utils/utils.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  onChangeLoading(bool loading) async {
    emit(state.copyWith(loading: loading));
  }

  onChangeFirstName(String? firstName) async {
    emit(state.copyWith(firstName: firstName));
  }

  onChangeLastName(String? lastName) async {
    emit(state.copyWith(lastName: lastName));
  }

  onChangeProfilePicture(File? file) async {
    if (file == null || file.path == '') {
      emit(state.copyWith(profilePicture: File('')));
    } else {
      emit(state.copyWith(profilePicture: file));
    }
  }

  updateProfile(BuildContext context) async {
    emit(state.copyWith(loading: true));
    await ProfileSevices.updateProfile(context);
    emit(state.copyWith(loading: false));
  }
}
