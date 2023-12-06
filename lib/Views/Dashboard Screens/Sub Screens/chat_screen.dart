import 'package:dashtanehunar/Blocs/Dashboard%20Cubit/cubit/dashboard_cubit.dart';
import 'package:dashtanehunar/models/chat_moel.dart';
import 'package:dashtanehunar/Blocs/Chat%20Cubit/cubit/chat_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final TextEditingController messageController = TextEditingController();
    return Scaffold(
      bottomNavigationBar: Container(
        height: 45,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: primaryColor, width: 1),
                  color: kWhite,
                ),
                child: CustomTextField(
                  enabled: context.watch<DashboardCubit>().state.currentScreenIndex==2?true:false,
                  controller: messageController,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  hintText: 'Write your message here....',
                  onChanged: (value) {
                    context.read<ChatCubit>().onChangeMessage(value);
                  },
                  validator: (p0) {
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                if(!context.read<ChatCubit>().state.loading){
                  messageController.clear();
                  context.read<ChatCubit>().sendMessage(context);
                }
              },
              icon: const Icon(Icons.send_outlined, color: primaryColor),
            )
          ],
        ),
      ),
    
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state.chatList?.isEmpty ?? true) {
                return const Center(
                  child: CustomText(text: 'No chat found'),
                );
              }
      
              // Scroll to the bottom whenever the widget is built or the list updates
              WidgetsBinding.instance.addPostFrameCallback((_) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
      
              return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: state.chatList?.length ?? 0,
                itemBuilder: (context, index) {
                  ChatModel? chatModel = state.chatList?[index];
                  if (chatModel?.senderId ==
                      context.read<LoginCubit>().state.userData?['uid']) {
                    return buildSentMessage(
                      chatModel?.message ?? '',
                    );
                  }
                  return buildReceivedMessage(
                    chatModel?.message ?? '',
                  );
                },
              );
            },
          ),
        ),
      ),
   
    );
  }

  Widget buildReceivedMessage(String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildSentMessage(String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
