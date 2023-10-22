import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dashtanehunar/Blocs/Signup/sign_up_cubit.dart';

import '../Utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController shopName = TextEditingController();
  final TextEditingController shopDescription = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    shopName.dispose();
    shopDescription.dispose();
    bankName.dispose();
    accountNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Create a Shop",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.error != null) {
            SnackBarService.showSnackBar(context,
                title: "!Oh Snap",
                message: "Unable to create a shop",
                contentType: ContentType.failure);
          }
        },
        builder: (context, state) {
          if (state.loading) {
            return const SizedBox(
                height: 70, width: double.infinity, child: CustomLoader());
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
                text: "Create",
                function: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<SignUpCubit>().signUpUser(
                        context,
                        email.text,
                        password.text,
                        firstName.text,
                        lastName.text,
                        shopName.text,
                        shopDescription.text,
                        bankName.text,
                        accountNumber.text);
                  }
                }),
          );
        },
      ),
      backgroundColor: kGrey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                LoginPageState().infoFields(
                  "First name",
                  "Ex. John",
                  controller: firstName,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Field is mandatory";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginPageState().infoFields(
                  "Last name",
                  "Ex. Doe",
                  controller: lastName,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Field is mandatory";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginPageState().infoFields(
                  "Email",
                  "Ex. john@example.com",
                  controller: email,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Field is mandatory";
                    }
                    if (!value.contains('@')) {
                      return "email format is incorrect";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginPageState().infoFields(
                  "Password",
                  "**********",
                  controller: password,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Field is mandatory";
                    }
                    if (value.length < 6) {
                      return "Password should be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginPageState().infoFields(
                  "Shop name",
                  "Ex. Export goods",
                  controller: shopName,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Field is mandatory";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginPageState().infoFields(
                  "Shop description",
                  "Highlights of the store",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  controller: shopDescription,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Field is mandatory";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginPageState().infoFields(
                  "Bank name",
                  "Ex. Meezan Bank",
                  controller: bankName,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Field is mandatory";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginPageState().infoFields(
                  "Account number",
                  "Ex. 65125636717",
                  controller: accountNumber,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Field is mandatory";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sellerType() {
    String? groupValue = "Individual";
    return StatefulBuilder(builder: (context, changeState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(text: "Seller Type"),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Radio(
                value: "Individual",
                groupValue: groupValue,
                onChanged: (value) => changeState(
                  () => groupValue = value,
                ),
              ),
              const CustomText(text: "Individual"),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Business",
                groupValue: groupValue,
                onChanged: (value) => changeState(
                  () => groupValue = value,
                ),
              ),
              const CustomText(text: "Business"),
            ],
          ),
        ],
      );
    });
  }
}
