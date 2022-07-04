import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/chat/chat.dart';
import 'package:fitween1/presenter/page/chatroom.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
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
    return Card(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          DateFormat.yMMMd().format(chat.date),
          style: const TextStyle(color: Colors.white),
        ),
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
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: ChatroomPresenter.textCont,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    hintText: 'Type your message here...',
                  ),
                  onFieldSubmitted: (_) => controller.addChat,
                ),
              ),
              IconButton(
                onPressed: controller.addChat,
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        );
      }
    );
  }
}


