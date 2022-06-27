import 'package:fitween1/global/global.dart';
import 'package:fitween1/global/palette.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 미완료 피트위너 뷰 위젯
class IncompleteTraineeView extends StatelessWidget {
  const IncompleteTraineeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPresenter>(
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin.width,
                vertical: defaultMargin.height,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.mark_chat_unread_outlined, size: 15.0,),
                      SizedBox(width: 5.0),
                      FWText('미완료 피트위너 3명', size: 10.0),
                    ],
                  ),
                  FWButton(
                    onPressed: () {},
                    text: '전체 알림 보내기',
                    fontSize: 10.0,
                    width: 90.0,
                    height: 22.0,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: defaultMargin.height,
                bottom: defaultMargin.height,
                left: defaultMargin.width,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    10, (_) => Row(
                    children: [
                      ProfileImageCircle(user: controller.user, active: true),
                      const SizedBox(width: 15.0),
                    ],
                  ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}

// 피트위너 관리 카드 뷰 위젯
class TraineeManageCardView extends StatelessWidget {
  const TraineeManageCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => const TraineeManageCard(),
      ),
    );
  }
}

// 피트위너 관리 카드
class TraineeManageCard extends StatelessWidget {
  const TraineeManageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPresenter>(
      builder: (controller) {
        return Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.all(20.0),
          color: Palette.white,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ProfileImageCircle(user: controller.user),
                    const SizedBox(width: 9.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FWText(
                          controller.user.nickname ?? '#',
                          size: 12.0,
                        ),
                        Column(
                          children: const [
                            FWText('#다이어트', size: 12.0, color: Palette.dark),
                            FWText('#5kg감량', size: 12.0, color: Palette.dark),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FWText('식단'),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.circle, size: 12.0),
                            SizedBox(width: 3.0),
                            FWText('아침', size: 10.0),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.circle_outlined, size: 12.0),
                            SizedBox(width: 3.0),
                            FWText('점심', size: 10.0),
                          ],
                        ),Row(
                          children: const [
                            Icon(Icons.circle_outlined, size: 12.0),
                            SizedBox(width: 3.0),
                            FWText('저녁', size: 10.0),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: const [
                            Icon(Icons.edit_note_outlined),
                            SizedBox(width: 6.0),
                            FWText('플랜 수정', size: 10.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
