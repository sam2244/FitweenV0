import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/before_main/greeting.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNewUser = Get.arguments ?? false;

    return Scaffold(
      body: isNewUser ? SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FWText('만나서 반가워요,\n당신에 대해 더 알고 싶어요!',
                    style: Theme.of(context).textTheme.titleLarge,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 70.0),
                GreetingPresenter.picture,
                const SizedBox(height: 70.0),
                FWButton(
                  onPressed: () => GreetingPresenter.nextPressed(isNewUser),
                  text: '피트윈 시작하기',
                  width: 200.0,
                ),
              ],
            ),
          ],
        ),
      ) : GetBuilder<UserPresenter>(
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GreetingPresenter.picture,
              const SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FWText('돌아와서 반가워요 ',
                    style: Theme.of(context).textTheme.titleLarge,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  FWText(controller.user.nickname!,
                    style: Theme.of(context).textTheme.titleLarge,
                    color: FWTheme.primary[60],
                  ),
                  FWText('님,',
                    style: Theme.of(context).textTheme.titleLarge,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              FWText('오늘도 힘차게 시작해볼까요?',
                style: Theme.of(context).textTheme.bodyMedium,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 50.0),
              FWButton(
                onPressed: () => GreetingPresenter.nextPressed(isNewUser),
                text: '피트윈 시작하기',
                width: 200.0,
              ),
            ],
          );
        }
      ),
    );
  }
}
