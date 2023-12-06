part of 'notification_cubit.dart';

class  NotificationState {
  final bool loading;
  final List<NotificationModel>? notificationList;

  NotificationState({this.loading = false, this.notificationList});

  NotificationState copyWith({
    final bool? loading, 
    final List<NotificationModel>? notificationList, 
  }){
    return NotificationState(
      loading:  loading ?? this.loading, 
      notificationList: notificationList ?? this.notificationList,
    );
  }
}
