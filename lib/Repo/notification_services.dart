import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Blocs/Notification%20Cubit/cubit/notification_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:http/http.dart' as http;
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


    static Future<void> readNotifications(List<NotificationModel>? list)async{
    for(NotificationModel i in list??[]){
      if(i.isReaded=="0"){
        await FirebaseFirestore.instance.collection('notifications').doc(i.id).update({"isReaded":"1"});
      }
    }
  }




static Future<void> sendNotification(String? title, String? message, String? token)async{
  try{
  await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  headers: {
    HttpHeaders.contentTypeHeader: 'application/json', 
    HttpHeaders.authorizationHeader: 'key=AAAA2CB0pqw:APA91bHPw84nQE-DMDjGExVmx1BxVAwueUNaPyLLAJF1ZSLVV3hGgQLQJKLQ3-WHSfluGMLSGNh4gpkey5Wc9cus1haauI4r5bmSAG8ajG_qps4gczMNDNaiFQ37__PnNdsevwTuoD2G',

  },
  body: jsonEncode({
    "to":token??"",
    "notification":{
      "title": title??"", 
      "body": message??"",
    }
  })
  ).then((value){

  });
  }catch(e){
    debugPrint(e.toString());
  }
}
static Future<void> sendNotificationForScreen(String? title, String? message, String? uid)async{
  String? docId = FirebaseFirestore.instance.collection('notifications').doc().id;
  await FirebaseFirestore.instance.collection('notifications').doc(docId).set({
    "from": "Support", 
    "id":docId, 
    "isReaded": "0", 
    "message": message??"", 
    "title": title??"",
    "sentTime": DateTime.now().millisecondsSinceEpoch, 
    "to": uid??""

  });
}

}