import 'package:fitween1/view/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  FWButton(
                    onPressed: () => Get.toNamed('/register'),
                    text: '회원가입',
                    width: 100.0,
                  ),
                  const SizedBox(width: 20.0),
                  const Text('RegisterPage()'),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  FWButton(
                    onPressed: () => Get.toNamed('/main/trainer'),
                    text: '트레이너 메인',
                    width: 100.0,
                  ),
                  const SizedBox(width: 20.0),
                  const Text('MainPage(role: Role.trainer)'),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  FWButton(
                    onPressed: () => Get.toNamed('/main/trainee'),
                    text: '피트위너 메인',
                    width: 100.0,
                  ),
                  const SizedBox(width: 20.0),
                  const Text('MainPage(role: Role.trainee)'),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  FWButton(
                    onPressed: () => Get.toNamed('/addPlan'),
                    text: '플랜추가',
                    width: 100.0,
                  ),
                  const SizedBox(width: 20.0),
                  const Text('AddPlanPage()'),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  FWButton(
                    onPressed: () => Get.toNamed('/my'),
                    text: '마이페이지',
                    width: 100.0,
                  ),
                  const SizedBox(width: 20.0),
                  const Text('MyPage()'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
