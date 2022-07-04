import 'package:fitween1/model/chat/chat.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatroomPresenter extends GetxController {
  List<Chat> chats = [];

  static final userPresenter = Get.find<UserPresenter>();
  static final textCont = TextEditingController();

  bool isMe(Chat chat) => userPresenter.isMe(chat.user);

  void addChat() {
    chats.add(Chat(
      user: userPresenter.user,
      text: textCont.text,
      date: DateTime.now(),
    ));
    textCont.clear();
    update();
  }
}