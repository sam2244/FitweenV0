import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/chat/chat.dart';
import 'package:fitween1/presenter/page/chat/chatroom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

// 채팅 페이지 AppBar
class ChatroomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatroomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(ChatroomPresenter.userPresenter.user.nickname!),
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        iconSize: 36.0,
        color: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}

// 채팅창 뷰 위젯
class ChatroomView extends StatelessWidget {
  const ChatroomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatroomPresenter>(
      builder: (controller) {
        return Expanded(
          child: GroupedListView<Chat, DateTime>(
            padding: const EdgeInsets.all(8),
            reverse: true,
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            elements: controller.chats,
            groupBy: (chat) => chat.ignoreTime(),
            groupHeaderBuilder: (chat) => DateTimeCard(chat: chat),
            itemBuilder: (_, chat) => ChatBubbleCard(chat: chat),
          ),
        );
      }
    );
  }
}

// 상단 일자 표시 카드 위젯
class DateTimeCard extends StatelessWidget {
  const DateTimeCard({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        DateFormat('yyyy.MM.dd E', 'ko_KR').format(chat.date),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

// 말풍선 카드 위젯
class ChatBubbleCard extends StatelessWidget {
  const ChatBubbleCard({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatroomPresenter>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: controller.isMe(chat)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300.0),
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(chat.text),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}

// 하단 사용자 입력창 위젯
class BottomUserInputField extends StatelessWidget {
  const BottomUserInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatroomPresenter>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24.0, 6.0, 10.0, 14.0),
          color: Theme.of(context).colorScheme.onPrimary,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: ChatroomPresenter.textCont,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(24.0, 6.0, 10.0, 0.0),
                    hintText: '메세지 보내기...',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onFieldSubmitted: (_) => controller.addChat,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 24.0, 0.0),
                child: Container(
                  width: 44.0,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    color: Theme.of(context).colorScheme.onPrimary,
                    onPressed: controller.addChat,
                  ),
                ),
              ),

            ],
          ),
        );
      }
    );
  }
}


