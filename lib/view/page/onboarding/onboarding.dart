import 'package:fitween1/view/page/onboarding/widget.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:flutter/material.dart';
import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/global/global.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Parallax()
    );
  }
}
