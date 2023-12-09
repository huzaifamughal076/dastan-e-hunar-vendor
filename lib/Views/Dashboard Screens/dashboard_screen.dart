import 'package:dashtanehunar/Blocs/Chat%20Cubit/cubit/chat_cubit.dart';
import 'package:dashtanehunar/Blocs/Dashboard%20Cubit/cubit/dashboard_cubit.dart';
import 'package:dashtanehunar/Blocs/Feed%20Cubit/cubit/feed_cubit.dart';
import 'package:dashtanehunar/Blocs/Notification%20Cubit/cubit/notification_cubit.dart';
import 'package:dashtanehunar/Notification%20Services/Firebase%20Services/firebase_service.dart';
import 'package:dashtanehunar/Notification%20Services/Local%20Notifications/local_notification_service.dart';
import 'package:dashtanehunar/Repo/notification_services.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/chat_screen.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/feed_screen.dart';
import 'package:dashtanehunar/Views/Dashboard%20Screens/Sub%20Screens/Profile%20Screens/profile_page.dart';
import 'package:dashtanehunar/Widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FeedScreen(),
    ChatScreen(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FeedCubit>(context).getFeeds(context);
    BlocProvider.of<ChatCubit>(context)
        .getChat(context, context.read<LoginCubit>().state.userData?['uid']);
    BlocProvider.of<NotificationCubit>(context).getNotifications(
        context, context.read<LoginCubit>().state.userData?['uid']);
    BlocProvider.of<DashboardCubit>(context).getAllOrders(
        context, context.read<LoginCubit>().state.userData?['uid']);
    LocalNotificationService.initialize(context);
    FirebaseNotificationService().handleTokenStatus(context);
    FirebaseNotificationService().handleOnTapBackground(context);
    FirebaseNotificationService().handleOnMessage();
    FirebaseNotificationService().handleAppOpened(context);
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        Map<String, dynamic>? userData =
            context.watch<LoginCubit>().state.userData;
        return Scaffold(
            backgroundColor: kWhite,
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: kWhite,
              title: Text(
                dashboardAppbarNamer(state, context),
                style: const TextStyle(color: kBlack),
              ),
              centerTitle: true,
              elevation: 0,
              toolbarHeight: 50,
              actions: [
                BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: () {
                          NotificationServices.readNotifications(state.notificationList);
                          Navigator.pushNamed(
                              context, AppRoutes.notificationsScreen);
                        },
                        icon: Badge(
                    backgroundColor: kOrange,
                    isLabelVisible: (state.notificationList?.any((element) => element.isReaded=="0")??false),
                          child: const Icon(
                            Icons.notifications,
                            color: kBlack,
                          ),
                        ));
                  },
                )
              ],
              bottom: (userData?['accountStatus'] == "unActive")
                  ? PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: Container(
                        color: kRed.withOpacity(0.4),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.maxFinite,
                        height: 50,
                        child: Row(
                          children: [
                            const Expanded(
                                child: CustomText(
                              text:
                                  'To publish your shop please register your shop',
                              textAlign: TextAlign.left,
                              fontsize: 13,
                            )),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 35,
                              child: CustomButton(
                                text: '  Register  ',
                                function: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.registrationPage);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : (userData?['accountStatus'].toLowerCase() == "pending")
                      ? PreferredSize(
                          preferredSize: const Size.fromHeight(40),
                          child: Container(
                            color: kYellow.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: double.maxFinite,
                            height: 50,
                            child: const Row(
                              children: [
                                Expanded(
                                    child: CustomText(
                                  text:
                                      'Thanks for your registration your store sent for approval please stay patient we\'ll reach with in 2-3 days',
                                  textAlign: TextAlign.left,
                                  fontsize: 13,
                                )),
                              ],
                            ),
                          ),
                        )
                      : PreferredSize(
                          preferredSize: const Size(double.maxFinite, 0),
                          child: Container(),
                        ),
            ),
            body: IndexedStack(
              index: context.read<DashboardCubit>().state.currentScreenIndex,
              children: _widgetOptions,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: _navBarsItems(),
              onTap: (value) {
                context.read<DashboardCubit>().onChangeCurrentIndex(value);
              },
              currentIndex: state.currentScreenIndex,
              fixedColor: kWhite,
              showSelectedLabels: false,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: kGrey,
              showUnselectedLabels: false,
            ));
      },
    );
  }

  String dashboardAppbarNamer(DashboardState state, BuildContext context) =>
      (state.currentScreenIndex == 0)
          ? '${context.read<LoginCubit>().state.userData?["shopName"] ?? ""}'
          : (state.currentScreenIndex == 1)
              ? 'Feeds'
              : (state.currentScreenIndex == 2)
                  ? 'Support'
                  : (state.currentScreenIndex == 3)
                      ? 'Profile'
                      : 'Dastan-e-Hunar';
  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          activeIcon: Icon(
            CupertinoIcons.house_fill,
            color: primaryColor,
          ),
          label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.flame,
          ),
          activeIcon: Icon(
            CupertinoIcons.flame_fill,
            color: primaryColor,
          ),
          label: 'Feeds'),
      const BottomNavigationBarItem(
        icon: Icon(
          CupertinoIcons.chat_bubble_text,
        ),
        label: "Chats",
        activeIcon: Icon(
          CupertinoIcons.chat_bubble_text_fill,
          color: primaryColor,
        ),
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person),
        label: "Profile",
        activeIcon: Icon(
          CupertinoIcons.person_fill,
          color: primaryColor,
        ),
      ),
    ];
  }
}
