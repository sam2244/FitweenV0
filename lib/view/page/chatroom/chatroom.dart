import 'package:fitween1/view/page/chatroom/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatroomPage extends StatefulWidget {
  const ChatroomPage({Key? key}) : super(key: key);

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 25.0,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          ChatView(),
          BottomUserInputField(),
        ],
      ),
      //bottomNavigationBar: const MainBottomBar(),
    );
  }
}
