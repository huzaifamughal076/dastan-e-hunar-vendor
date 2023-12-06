import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Blocs/Chat%20Cubit/cubit/chat_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:dashtanehunar/models/chat_moel.dart';

class ChatServices{


static Future<void>getChat(BuildContext context, String? uid)async{
  FirebaseFirestore.instance.collection('chats').doc(uid).collection('chat').orderBy('sentTime', descending: false).snapshots().listen((event) {
    List<ChatModel>? list = [];
    for (var element in event.docs) {
      ChatModel model = ChatModel.fromMap(element.data());
      list.add(model);
     }
     context.read<ChatCubit>().setChatList(list);
   });
}


static Future<void> sendMessage(BuildContext context, String? message)async{
try{

    String? docId = FirebaseFirestore.instance.collection('chats').doc(context.read<LoginCubit>().state.userData?['uid']).collection('chat').doc().id;
  Map<String, dynamic>? userData = context.read<LoginCubit>().state.userData;
  ChatModel chatModel = ChatModel(
    id: docId,
    isreaded: "0", 
    message: message, 
    messageType: 'message', 
    receiverId: 'AB8J001K4POeKDkwjfPpS2DJYlZ2', 
    receiverName: 'Support', 
    senderId: userData?['uid'], 
    senderName: "${userData?['firstName']} ${userData?['lastName']}", 
    sentTime: DateTime.now().millisecondsSinceEpoch
  );

  await FirebaseFirestore.instance.collection('chats').doc(userData?['uid']).collection('chat').doc(docId).set(chatModel.toMap()).then((value) {
    context.read<ChatCubit>().onChangeMessage('');
  });


}on FirebaseException catch(e){


print(e.message);
  // SnackBarService.showSnackBar(context, 
  // title: 'We are Sorry', message: "${e.message}", contentType: ContentType.failure);

}
}
  
}