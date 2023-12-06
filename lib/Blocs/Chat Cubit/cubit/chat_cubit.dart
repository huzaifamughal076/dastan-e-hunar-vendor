import 'package:dashtanehunar/Repo/chat_services.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:dashtanehunar/models/chat_moel.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());


setChatList(List<ChatModel>? list)async{
  emit(state.copyWith(chatList: list));
}

onChangeMessage(String? message)async{
  emit(state.copyWith(message: message));
}

  getChat(BuildContext context, uid)async{
    await ChatServices.getChat(context, uid);
  }


  sendMessage(BuildContext context)async{
    emit(state.copyWith(loading:  true));
    await ChatServices.sendMessage(context, state.message);
    emit(state.copyWith(loading: false));
  }
}
