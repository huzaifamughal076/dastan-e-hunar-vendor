import 'package:dashtanehunar/Blocs/Notification%20Cubit/cubit/notification_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifcations',
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_rounded,
              color: kBlack,
            )),
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state.loading) {
                  return const CustomLoader();
                }
                if (state.notificationList?.isEmpty ?? true) {
                  return const Center(
                    child: CustomText(text: 'No notification found'),
                  );
                }
                return ListView.builder(
                  itemCount: state.notificationList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return notificationWidget(
                        title: state.notificationList?[index].title,
                        value: state.notificationList?[index].message);
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  Container notificationWidget({String? title, String? value}) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                offset: const Offset(2, 3),
                spreadRadius: 2,
                color: kBlack.withOpacity(0.1))
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.notifications,
            color: primaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
                children: [
                  Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$title',
              maxLines: 3,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
                  Align(
            alignment: Alignment.centerLeft,
            child: Text(
                  '$value',
                  maxLines: 3,
                  textAlign: TextAlign.left,
            ),
          ),
                ],
              )),
        ],
      ),
    );
  }
}
