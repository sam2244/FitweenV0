import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Fitween 로고
class FWLogo extends StatelessWidget {
  const FWLogo({Key? key}) : super(key: key);

  static const String asset = 'assets/img/logo/fitween.svg';

  @override
  Widget build(BuildContext context) => SvgPicture.asset(asset);
}

// 원형 프로필 사진
class ProfileImageCircle extends StatelessWidget {
  ProfileImageCircle({
    Key? key,
    this.user,
    this.active = false,
    this.size = 45.0,
    this.color,
    this.onPressed,
  }) : super(key: key);

  final FWUser? user;
  final bool active;
  final double size;
  Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    color ??= Theme.of(context).colorScheme.primaryContainer;

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(100.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: size,
          minHeight: size,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(100.0),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: active
                    ? Colors.green
                    : Colors.transparent,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.network(
                user == null
                    ? UserPresenter.defaultProfile
                    : user!.imageUrl,
              )
            ),
          ),
        ),
      ),
    );
  }
}
