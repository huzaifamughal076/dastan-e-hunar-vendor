import 'dart:convert';

import 'package:dashtanehunar/Blocs/Add%20Product/add_product_cubit.dart';
import 'package:dashtanehunar/Blocs/Chat%20Cubit/cubit/chat_cubit.dart';
import 'package:dashtanehunar/Blocs/Dashboard%20Cubit/cubit/dashboard_cubit.dart';
import 'package:dashtanehunar/Blocs/Feed%20Cubit/cubit/feed_cubit.dart';
import 'package:dashtanehunar/Blocs/Get%20product/get_product_cubit.dart';
import 'package:dashtanehunar/Blocs/Notification%20Cubit/cubit/notification_cubit.dart';
import 'package:dashtanehunar/Blocs/Profile%20Cubit/cubit/profile_cubit.dart';
import 'package:dashtanehunar/Blocs/Signup/sign_up_cubit.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/Notification%20Screen/notification_screen.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/Profile%20Screens/Sub%20Screens/About%20Us/about_us.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/Profile%20Screens/Sub%20Screens/FAQ%20Page/faq_page.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/Profile%20Screens/Sub%20Screens/My%20Profile%20Screen/my_profile.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/Profile%20Screens/Sub%20Screens/Privacy%20Policy/privacy_policy.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/Profile%20Screens/Sub%20Screens/Terms%20And%20Conditions/terms_and_conditions.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/chat_screen.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/feed_screen.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/dashboard_screen.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/registration_screen.dart';

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
        route: AppRoutes.dashboardScreen,
        page: const DashboardScreen(),
        bloc: BlocProvider(
          create: (context) => DashboardCubit(),
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
          route: AppRoutes.feeds,
          page: const FeedScreen(),
          bloc: BlocProvider(
            create: (context) => FeedCubit(),
          )),
      PageEntity(
          route: AppRoutes.addProduct,
          page: const AddProductPage(),
          bloc: BlocProvider(
            create: (context) => AddProductCubit(),
          )),
          PageEntity(
          route: AppRoutes.editProduct,
          page: const EditProductPage(),
          bloc: BlocProvider(
            create: (context) => EditProductCubit(),
          )),
      PageEntity(
        route: AppRoutes.productDetail,
        page: const ProductDetailPage(),
      ), 
      PageEntity(
        route: AppRoutes.registrationPage,
        page: const RegistrationScreen(),
      ), 
      PageEntity(
        route: AppRoutes.myProfileScreen,
        page: const MyProfileScreen(),
        bloc: BlocProvider(create: (context) => ProfileCubit(),)
      ),  
      PageEntity(
        route: AppRoutes.termsAndConditions,
        page: const TermsAndConditions(),
      ),
      PageEntity(
        route: AppRoutes.privacyPolicy,
        page: const PrivacyPolicy(),
      ),
      PageEntity(
        route: AppRoutes.notificationsScreen,
        page: const NotificationsScreen(),
        bloc: BlocProvider(create: (context) => NotificationCubit(),)
      ),
      PageEntity(
        route: AppRoutes.aboutUs,
        page: const AboutUs(),
      ),
      PageEntity(
        route: AppRoutes.fAQPage,
        page: const FAQPage(),
      ),
      PageEntity(
        route: AppRoutes.chatScreen,
        page: const ChatScreen(),
        bloc: BlocProvider(create: (context) => ChatCubit(),)
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
                context.read<GetProductCubit>().getProducts(jsonDecode(jsonAuthModel)?["uid"]);
                  context.read<LoginCubit>().setUserData(jsonDecode(jsonAuthModel));
                    return const DashboardScreen();
                 
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
