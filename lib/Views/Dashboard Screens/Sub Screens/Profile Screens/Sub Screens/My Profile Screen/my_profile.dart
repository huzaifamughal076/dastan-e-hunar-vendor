import 'package:dashtanehunar/Blocs/Profile%20Cubit/cubit/profile_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    context.read<ProfileCubit>().onChangeFirstName(
        context.read<LoginCubit>().state.userData?['firstName']);
    context.read<ProfileCubit>().onChangeLastName(
        context.read<LoginCubit>().state.userData?['lastName']);

    return WillPopScope(
      onWillPop: () async {
        await context.read<ProfileCubit>().onChangeProfilePicture(File(''));
        return true;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          title: const Text(
            'My Profile',
            style: TextStyle(color: kBlack),
          ),
          centerTitle: true,
          backgroundColor: kWhite,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProfileCubit>().onChangeProfilePicture(File(''));
              },
              icon: const Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 30,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),

                    Center(
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          // border: Border.all(color: primaryColor, width: 1),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: primaryColor, width: 1)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: (state.profilePicture?.path
                                                .isNotEmpty ??
                                            false)
                                        ? Image.file(
                                            File(state.profilePicture?.path ??
                                                ""),
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/logo.jpeg');
                                          },
                                            fit: BoxFit.fill,
                                            scale: 0.5,
                                            cacheWidth: 150,
                                            cacheHeight: 150)
                                        : ((context
                                                    .read<LoginCubit>()
                                                    .state
                                                    .userData?['profileUrl'] as String?)?.isNotEmpty ??
                                                false)
                                            ? Image.network(
                                                '${context.read<LoginCubit>().state.userData?['profileUrl']}',
                                                fit: BoxFit.fill,
                                                scale: 0.5,
                                                cacheWidth: 150,
                                                cacheHeight: 150,
                                              )
                                            : Image.asset(
                                                'assets/logo.jpeg',
                                                fit: BoxFit.fill,
                                                scale: 0.5,
                                                cacheWidth: 150,
                                                cacheHeight: 150,
                                              )),
                              ),
                            ),
                            Positioned(
                                bottom: -5,
                                right: -5,
                                child: Material(
                                  elevation: 4,
                                  shape: const CircleBorder(),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 34,
                                    width: 34,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kWhite,
                                    ),
                                    child: IconButton(
                                        onPressed: () async {
                                          await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery)
                                              .then((value) {
                                            if (value != null) {
                                              context
                                                  .read<ProfileCubit>()
                                                  .onChangeProfilePicture(
                                                      File(value.path));
                                            }
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt_outlined,
                                          color: kBlack,
                                          size: 20,
                                        )),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                        child: CustomText(
                      text:
                          '${context.read<LoginCubit>().state.userData?['email']}',
                      fontWeight: FontWeight.bold,
                      fontsize: 18,
                    )),

                    const SizedBox(
                      height: 60,
                    ),
                    // const Spacer(),

                    Form(
                      key: formKey,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kGrey.shade200),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: 'First Name',
                              color: primaryColor,
                              fontsize: 15,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            CustomTextField(
                              initialValue: state.firstName,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              hintText: "First Name",
                              validator: (value) {
                                if (state.firstName?.isEmpty ?? true) {
                                  return "First Name Required";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                context
                                    .read<ProfileCubit>()
                                    .onChangeFirstName(value);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const CustomText(
                              text: 'Last Name',
                              color: primaryColor,
                              fontsize: 15,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            CustomTextField(
                              initialValue: state.lastName,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              hintText: "Last Name",
                              validator: (value) {
                                if (context
                                        .read<ProfileCubit>()
                                        .state
                                        .lastName
                                        ?.isEmpty ??
                                    true) {
                                  return "Last Name Required";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                context
                                    .read<ProfileCubit>()
                                    .onChangeLastName(value);
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AnimatedCrossFade(
                                firstChild: CustomButton(
                                    text: 'Update',
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        context
                                            .read<ProfileCubit>()
                                            .updateProfile(context);
                                      }
                                    }),
                                secondChild: const SizedBox(
                                    height: 55,
                                    child: Center(
                                      child: CustomLoader(),
                                    )),
                                crossFadeState: (state.loading)
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 800))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
