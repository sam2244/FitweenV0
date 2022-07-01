import 'package:fitween1/view/page/register/widget.dart';
import 'package:flutter/material.dart';

// 회원가입 페이지
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: const Scaffold(
        appBar: RegisterAppBar(),
        body: CarouselView(),
      ),
    );
  }
}
