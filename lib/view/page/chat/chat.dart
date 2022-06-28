import 'package:fitween1/view/page/chat/widget.dart';
import 'package:fitween1/view/page/main/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
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
