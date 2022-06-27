import 'package:fitween1/global/palette.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Fitween 로고
class FWLogo extends StatelessWidget {
  const FWLogo({Key? key}) : super(key: key);

  static const String asset = 'assets/img/logo/fitween.svg';

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(50.0),
    child: SvgPicture.asset(asset),
  );
}

// 원형 프로필 사진
class ProfileImageCircle extends StatelessWidget {
  const ProfileImageCircle({
    Key? key,
    required this.user,
    this.active = false,
    this.size = 45.0,
  }) : super(key: key);

  final FWUser user;
  final bool active;
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
          color: Palette.grey,
          border: Border.all(
            width: 1,
            color: active ? Colors.green : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            'assets/img/guestuser.png',
          ),
        ),
      ),
    );
  }
}
