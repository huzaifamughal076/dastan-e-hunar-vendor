part of 'profile_cubit.dart';

 class ProfileState {
  final bool loading;
  final String? firstName;
  final String? lastName;
  final File? profilePicture;
  ProfileState({this.loading=false, this.firstName, this.lastName, this.profilePicture});

  ProfileState copyWith({
    final bool? loading,
    final String? firstName,
    final String? lastName,
    final File? profilePicture,
  }){
    return ProfileState(
      loading:  loading ?? this.loading,
      firstName: firstName ?? this.firstName, 
      lastName:  lastName ?? this.lastName,
      profilePicture:  profilePicture ?? this.profilePicture,
    );
  }
 }
