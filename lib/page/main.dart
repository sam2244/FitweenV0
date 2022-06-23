import 'package:fitween1/config/palette.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/widget/button.dart';
import 'package:fitween1/widget/profile.dart';
import 'package:fitween1/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FitweenUser user = Get.put(FitweenUser());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          shape: const Border(
            bottom: BorderSide(
              color: Palette.dark,
              width: .5,
            )
          ),
          titleSpacing: 0.0,
          title: Row(
            children: [
              SizedBox(width: defaultMargin.width),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FitweenText(user.nickname ?? '', size: 24.0),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Palette.dark,
                        ),
                      ),
                    ],
                  ),
                  const FitweenText('트레이너', size: 12.0, weight: 'Thin'),
                  const SizedBox(height: 6.5),
                ],
              ),
              Expanded(child: Container()),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Palette.dark,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Palette.light,
        child: Column(
          children: [
            Column(
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
                          FitweenText('미완료 피트위너 3명', size: 10.0),
                        ],
                      ),
                      FitweenButton(
                        onPressed: () {},
                        text: '전체 알림 보내기',
                        fontSize: 10.0,
                        width: 90.0,
                        height: 22.0,
                      ),
                    ],
                  ),
                ),
              ],
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
                        ProfileCircle(user: user),
                        const SizedBox(width: 15.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
              child: Stack(
                children: [
                  const Divider(
                    color: Color(0xFF8F8C8C),
                    thickness: 1.0,
                  ),
                  Positioned(
                    left: defaultMargin.width,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      color: Palette.light,
                      child: const FitweenText('피트위너', size: 20.0, color: Color(0xFF8F8C8C)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) => Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ProfileCircle(user: user, checked: true),
                            const SizedBox(width: 9.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FitweenText(
                                  user.nickname ?? '#',
                                  size: 12.0,
                                ),
                                Column(
                                  children: const [
                                    FitweenText('#다이어트', size: 12.0, color: Color(0xAA1F1F1F)),
                                    FitweenText('#5kg감량', size: 12.0, color: Color(0xAA1F1F1F)),
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
                            const FitweenText('식단'),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.circle, size: 12.0),
                                    SizedBox(width: 3.0),
                                    FitweenText('아침', size: 10.0),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.circle_outlined, size: 12.0),
                                    SizedBox(width: 3.0),
                                    FitweenText('점심', size: 10.0),
                                  ],
                                ),Row(
                                  children: const [
                                    Icon(Icons.circle_outlined, size: 12.0),
                                    SizedBox(width: 3.0),
                                    FitweenText('저녁', size: 10.0),
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
                                    FitweenText('플랜 수정', size: 10.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '달력',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '메시지',
          ),
        ],
      ),
    );
  }
}
