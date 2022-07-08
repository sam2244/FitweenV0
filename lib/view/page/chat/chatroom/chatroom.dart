import 'package:fitween1/view/page/chat/chatroom/widget.dart';
import 'package:flutter/material.dart';

class ChatroomPage extends StatefulWidget {
  const ChatroomPage({Key? key}) : super(key: key);

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatroomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          ChatroomView(),
          BottomUserInputField(),
        ],
      ),
      //bottomNavigationBar: const MainBottomBar(),
    );
  }
}
