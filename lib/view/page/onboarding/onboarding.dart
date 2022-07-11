import 'package:fitween1/view/page/onboarding/widget.dart';
import 'package:flutter/material.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Parallax(),
    );
  }
}
