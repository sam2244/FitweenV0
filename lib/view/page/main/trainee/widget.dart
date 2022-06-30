import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/page/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../widget/container.dart';

//피트위너 페이지의 위젯 모음

//피트위너 페이지 Body CarouselSlider Widget
class TraineeCarousel extends StatelessWidget {
  const TraineeCarousel({Key? key, required this.role}) : super(key: key);

  final Role role;

  @override
  Widget build(BuildContext context) {
    final List<Widget> cardList = [
      const TraineeCard(),
    ];

    final double height = MediaQuery
        .of(context)
        .size
        .height;
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: cardList
          .map((item) =>
          Container(
            child: const Center(
                child: TraineeCard()
            ),
          ))
          .toList(),
    );
  }
}

//피트위너 카드 리스트
class TraineeCard extends StatelessWidget {
  const TraineeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FWCard(
          child: Row(
            children: [
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: Container(
                  color: FWTheme.light,
                  child: Icon(Icons.account_circle_outlined),
                  width: 300.0,
                  height: 300.0,
                )
              ),
              Column(
                children: const [
                  SizedBox(
                    child:
                    Text(
                      "Nickname",
                      style: TextStyle(color: FWTheme.dark),
                    ),

                  ),
                  SizedBox(
                    child:
                      Text(
                        "D-50",
                        style: TextStyle(color: FWTheme.dark),
                      ),
                  ),
                ],
              )
            ],
          )
        ),
      ],
    );
  }
}

