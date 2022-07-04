import 'package:fitween1/view/page/login/widget.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:flutter/material.dart';

// 로그인 페이지
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // 임시 AppBar
      appBar: LoginAppBar(),
      body: Stack(
        children: [
          // 중앙에 로고 배치
          const Positioned.fill(
            top: -60.0,
            // child: Center(
            //   child: Padding(
            //     padding: EdgeInsets.all(50.0),
            //     child: FWLogo(),
            //   ),
            // ),
            child: Padding(
              padding: EdgeInsets.all(50.0),
              child: FWLogo(),
            ),
          ),

          // 로그인 버튼
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(child: SizedBox()),

                  // 구글 로그인 버튼
                  SignInButton(type: LoginType.google),
                  SizedBox(height: 15.0),

                  // 애플 로그인 버튼
                  SignInButton(type: LoginType.apple),
                  SizedBox(height: 77.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}