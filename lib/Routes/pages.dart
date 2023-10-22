import 'package:dashtanehunar/Blocs/Add%20Product/add_product_cubit.dart';
import 'package:dashtanehunar/Blocs/Get%20product/get_product_cubit.dart';
import 'package:dashtanehunar/Blocs/Signup/sign_up_cubit.dart';

import '../Utils/utils.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.login,
        page: const LoginPage(),
        bloc: BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ),
      PageEntity(
          route: AppRoutes.signUp,
          page: const SignUpPage(),
          bloc: BlocProvider(
            create: (context) => SignUpCubit(),
          )),
      PageEntity(
          route: AppRoutes.home,
          page: const HomePage(),
          bloc: BlocProvider(
            create: (context) => GetProductCubit(),
          )),
      PageEntity(
          route: AppRoutes.addProduct,
          page: const AddProductPage(),
          bloc: BlocProvider(
            create: (context) => AddProductCubit(),
          )),
      PageEntity(
        route: AppRoutes.productDetail,
        page: const ProductDetailPage(),
      ),
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = [];
    for (var element in routes()) {
      if (element.bloc != null) {
        blocProviders.add(element.bloc);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        String? jsonAuthModel =
            Global.storageService.getAuthenticationModelString();
        if (jsonAuthModel != null && result.first.route == AppRoutes.login) {
          return MaterialPageRoute(
              builder: (context) {
                return const LoginPage();
              },
              settings: settings);
        }

        return MaterialPageRoute(
            builder: (context) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (context) => const LoginPage(), settings: settings);
  }
}

class PageEntity {
  final String route;
  final Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}
