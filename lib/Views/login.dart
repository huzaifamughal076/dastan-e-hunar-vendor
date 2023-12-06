import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dashtanehunar/Blocs/Get%20product/get_product_cubit.dart';
import 'package:dashtanehunar/Widgets/custom_list_of_productType.dart';

import '../Utils/utils.dart';

final GlobalKey<LoginPageState> loginPage = GlobalKey();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController(text: 'huzaifa@gmail.com');
  final TextEditingController password = TextEditingController(text: '123456');
  TextEditingController? shopType = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/logo.jpeg",
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kGrey.shade200),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      infoFields(
                        "Email",
                        "john@example.com",
                        controller: email,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Field is mandatory";
                          }
                          if (!value.contains("@")) {
                            return "Email format incorrect";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      infoFields(
                        "Password",
                        "*********",
                        isPassword: true,
                        controller: password,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Field is mandatory";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state.requestStatus == RequestStatus.failure) {
                            SnackBarService.showSnackBar(context,
                                title: "Invalid Credientials",
                                message:
                                    "Make sure your credientials are correct",
                                contentType: ContentType.failure);
                          }
                          if (state.requestStatus == RequestStatus.success) {
                            if(context.read<LoginCubit>().state.userData?['accountStatus']=="block"){
                              SnackBarService.showSnackBar(context,
                                title: "Alert",
                                message:
                                    "Your account has been blocked by admin for any query contact admin",
                                contentType: ContentType.failure);

                                context.read<LoginCubit>().clearData();

                            }else{
                              SnackBarService.showSnackBar(context,
                                title: "Login Successfull",
                                message:
                                    "World is under you knees when you are powerful",
                                contentType: ContentType.success);
                            context
                                .read<GetProductCubit>()
                                .getProducts(state.userData?["uid"]);
                                List<String> list = displayCategories(context);
                                categoriesList = list;
                               Navigator.pushNamed(context, AppRoutes.dashboardScreen);
                            
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state.requestStatus == RequestStatus.loading) {
                            return const SizedBox(
                              height: 50,
                              child: CustomLoader(),
                            );
                          }
                          return CustomButton(
                              text: "Login",
                              function: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context
                                      .read<LoginCubit>()
                                      .login(email.text, password.text);
                                }
                              });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        text: "Open Shop",
                        invert: true,
                        function: () =>
                            Navigator.pushNamed(context, AppRoutes.signUp),
                        textColor: primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
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

  Widget infoFields(String label, String hint,
      {TextInputType? keyboardType,
      bool isPassword = false,
      String? Function(String?)? validator,
      int? maxLines = 1,
      EdgeInsetsGeometry? contentPadding,
      TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: label),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          controller: controller,
          hintText: hint,
          keyboardType: keyboardType,
          validator: validator,
          isPassword: isPassword,
          maxLines: maxLines,
          contentPadding: contentPadding,
        ),
      ],
    );
  }

}
