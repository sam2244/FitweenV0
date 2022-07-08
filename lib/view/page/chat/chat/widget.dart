import 'package:fitween1/global/global.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      centerTitle: false,
      title: FWText('친구', style: Theme.of(context).textTheme.headlineMedium),
      actions: [
        IconButton(
          onPressed: () {}, icon: const Icon(Icons.search),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}