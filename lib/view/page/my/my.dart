import 'package:fitween1/view/page/my/widget.dart';
import 'package:flutter/material.dart';

// 마이 페이지
class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text("사진"),
            ),
            Container(
              child: Text("닉네임"),
            ),
            Container(
              child: Text("차트"),
            ),
          ],
        ),
      )
    );
  }
}
