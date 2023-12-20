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
  final TextEditingController shopLocation = TextEditingController();
  TextEditingController? shopType = TextEditingController();
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
                text: "Next",
                function: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<SignUpCubit>().signUpUser(
                        context,
                        email.text,
                        password.text,
                        firstName.text,
                        lastName.text,
                        shopName.text,
                        shopType?.text??"",
                        shopLocation.text,
                        shopDescription.text,
                        bankName.text,
                        accountNumber.text,);
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
                  "Shop Location",
                  "Ex. Lahore",
                  controller: shopLocation,
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(text: 'What do you sell')),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: DropdownMenu(
                    errorText: (shopType?.text.trim().isEmpty??true)?"Field required":null,
                    width: MediaQuery.of(context).size.width * 0.9,
                    hintText: 'Select what you are selling',
                    dropdownMenuEntries: dropdownList,
                    controller: shopType,
                    inputDecorationTheme: const InputDecorationTheme(
                      fillColor: kWhite,
                      filled: true,
                      border: InputBorder.none, // Remove the border
                    ),
                    menuStyle: MenuStyle(
                      backgroundColor: const MaterialStatePropertyAll(kWhite),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: kTransparent, width: 0),
                      )),
                    ),
                  ),
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

  List<DropdownMenuEntry<String>> get dropdownList {
    return [
      const DropdownMenuEntry(
          value: "Home Decoration", label: 'Home Decoration'),
      const DropdownMenuEntry(
          value: "Fashion and Accessories", label: 'Fashion and Accessories'),
      const DropdownMenuEntry(
          value: "Textile and Fiber Arts", label: 'Textile and Fiber Arts'),
      const DropdownMenuEntry(
          value: "Woodwork and stone work", label: 'Woodwork and stone work'),
      const DropdownMenuEntry(
          value: "Candles and Soaps", label: 'Candles and Soaps'),
      const DropdownMenuEntry(value: "Jewelry", label: 'Jewelry'),
    ];
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
