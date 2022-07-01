import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/page/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

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
          const Center(
              child: TraineeCard()
          ))
          .toList(),
    );
  }
}

//피트위너 카드
class TraineeCard extends StatelessWidget {
  const TraineeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FWCard(
      child:
      Column(
        children: [
          Row(
            children: [
              Expanded(
                child:  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      color: FWTheme.light,
                      width: 100.0,
                      height: 100.0,
                      child: const Image(image: AssetImage("assets/img/guest.png",)),
                    )
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      alignment: Alignment.topLeft,
                      child:
                      const Text(
                          "Nickname",
                          style: TextStyle(
                              color: FWTheme.dark,
                              fontSize: 30.0)
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.centerLeft,
                      child:
                      const Text(
                        "D-50",
                        style: TextStyle(
                            color: FWTheme.dark,
                            fontSize: 40.0,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10.0, left: 5.0,),
                child: Text(
                  "할 일",
                  style: TextStyle(
                    color: FWTheme.darkScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    TraineeCheckBoxList(),
                    TraineeCheckBoxList(),
                    TraineeCheckBoxList(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

//피트위너 FAB
class TraineeFAB extends StatelessWidget {
  const TraineeFAB({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print("Not ready yet!");
      },
      backgroundColor: FWTheme.darkScheme.onPrimary,
      child: const Icon(Icons.edit, color: FWTheme.light,),
    );
  }
}

//피트위너 체크박스 뷰
class TraineeCheckBoxList extends StatefulWidget {
  const TraineeCheckBoxList({Key? key}) : super(key: key);

  @override
  State<TraineeCheckBoxList> createState() => _TraineeCheckBoxListState();
}

//피트위너 체크박스 위젯
class _TraineeCheckBoxListState extends  State<TraineeCheckBoxList>{
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: const Text('Running', ),
      value: timeDilation != 1.0,
      onChanged: (bool? value) {
      setState( () {
      timeDilation = value! ? 2.0 : 1.0;
          }
        );
      },
      secondary: const Icon(Icons.directions_run),
    );
  }
}


