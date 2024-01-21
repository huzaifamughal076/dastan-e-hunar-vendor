part of 'profile_cubit.dart';

 class ProfileState {
  final bool loading;
  final String? firstName;
  final String? lastName;
  final File? profilePicture;
  final bool? isUrdu;
  ProfileState({this.loading=false, this.firstName, this.lastName, this.profilePicture, this.isUrdu});

  ProfileState copyWith({
    final bool? loading,
    final String? firstName,
    final String? lastName,
    final File? profilePicture,
    final bool? isUrdu,
  }){
    return ProfileState(
      loading:  loading ?? this.loading,
      firstName: firstName ?? this.firstName, 
      lastName:  lastName ?? this.lastName,
      profilePicture:  profilePicture ?? this.profilePicture,
      isUrdu: isUrdu ?? this.isUrdu
    );
  }
 }
