import 'package:fitween1/global/global.dart';
import 'package:flutter/material.dart';

class AddPlanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddPlanAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}