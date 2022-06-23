import 'package:fitween1/model/user/user.dart';
import 'package:flutter/material.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({
    Key? key,
    required this.user,
    this.checked = false,
    this.size = 45.0,
  }) : super(key: key);

  final FitweenUser user;
  final bool checked;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: size,
        minHeight: size,
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.3),
          border: Border.all(
            width: 1,
            color: checked ? Colors.transparent : Colors.green,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            'asset/img/guest.png',
          ),
        ),
      ),
    );
  }
}
