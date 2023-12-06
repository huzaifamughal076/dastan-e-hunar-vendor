import 'package:dashtanehunar/Repo/notification_services.dart';
import 'package:dashtanehunar/models/notification_model.dart';
import 'package:dashtanehunar/Utils/utils.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState());


  setNotifications(List<NotificationModel> list){
    emit(state.copyWith(notificationList: list));
  }

  getNotifications(BuildContext context, String? uid)async{
    await NotificationServices.getNotifications(context,uid);
  }
}
