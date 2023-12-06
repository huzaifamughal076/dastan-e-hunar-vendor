import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Blocs/Notification%20Cubit/cubit/notification_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';

import '../models/notification_model.dart';

class NotificationServices{


  static Future<void> getNotifications(BuildContext context,String? uid)async{

     FirebaseFirestore.instance.collection('notifications').where('to',isEqualTo: '$uid').snapshots().listen((event) {
      List<NotificationModel> list= [];
      for (var element in event.docs) { 
        NotificationModel? model = NotificationModel.fromMap(element.data());
        list.add(model);
      }
      context.read<NotificationCubit>().setNotifications(list);
     });


  }
}