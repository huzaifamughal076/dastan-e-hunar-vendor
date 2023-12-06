part of 'chat_cubit.dart';

class ChatState {
  final List<ChatModel>? chatList;
  final String? message;
  final bool loading;
  

  ChatState({this.chatList, this.message, this.loading= false});


  ChatState copyWith({
    final List<ChatModel>? chatList,
    final String? message,
    final bool? loading,
    TextEditingController? messageController,
  }){
    return ChatState(
      chatList:  chatList ?? this.chatList,
      message:  message ?? this.message, 
      loading:  loading ?? this.loading
    );
  }
}
