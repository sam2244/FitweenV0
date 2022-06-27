import 'package:fitween1/view/page/chat/widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          ChatView(),
          BottomUserInputField(),
        ],
      ),
    );
  }
}
