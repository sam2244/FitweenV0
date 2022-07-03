import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/page/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../widget/container.dart';
import '../../../widget/text.dart';

//트레이니 페이지의 위젯 모음

//트레이니 페이지 Body CarouselSlider Widget
class TraineeCarousel extends StatelessWidget {
  const TraineeCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> cardList = [
      const TraineeCard(),
      const TraineeCard(),
    ];

    final double height = MediaQuery
        .of(context)
        .size
        .height;
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: cardList.length > 1,
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

//트레이니 카드
class TraineeCard extends StatelessWidget {
  const TraineeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FWCard(
              height: 600.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                      children: const [
                        TraineeProfile(),
                      ],
                    ),
                  TraineeCheckBoxList(),
                ],
              )
          ),
        ),
      ],
    );
  }
}

//트레이니 프로필
class TraineeProfile extends StatelessWidget {
  const TraineeProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Card(
        color: Colors.transparent,
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 120.0,
            width: 300.0,
            child: Row(
              children: const [
                TraineeProfileImage(),
                TraineeInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//트레이니 메인 페이지 트레이니 Image 위젯
class TraineeProfileImage extends StatelessWidget {
  const TraineeProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 10.0,
      percent: 0.8,
      center: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(50), // Image radius
          child: Image.network(
              'https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg',
              fit: BoxFit.cover),
        ),
      ),
      reverse: true,
      backgroundColor: Colors.transparent,
      linearGradient: const LinearGradient(
        colors: <Color>[Color(0xffB07BE6), Color(0xff5BA2E0)],
      ),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}

// 트레이니 메인 페이지 Trainee Information
class TraineeInfo extends StatelessWidget {
  const TraineeInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TraineeName(name: '최복원'),
        TraineeMainPageSubTitle(subtitle: 'D-Day'),
        TraineeMainPageGraph(total: 5, completed: 4),
      ],
    );
  }
}

class TraineeName extends StatelessWidget {
  final String name;
  const TraineeName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: FWText(
        name,
        color: Theme.of(context).colorScheme.onSurface,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

// 트레이니 메인 페이지 Subtitle
class TraineeMainPageSubTitle extends StatelessWidget {
  final String subtitle;
  const TraineeMainPageSubTitle({Key? key, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: FWText(
        subtitle,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

// 트레이니 메인 페이지 Graph
class TraineeMainPageGraph extends StatelessWidget {
  final int total;
  final int completed;

  const TraineeMainPageGraph(
      {Key? key, required this.completed, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: 180.0,
      lineHeight: 15,
      linearGradient: const LinearGradient(
        colors: <Color>[Color(0xffB07BE6), Color(0xff5BA2E0)],
      ),
      barRadius: const Radius.circular(10.0),
      percent: completed / total,
    );
  }
}

//트레이니 FAB
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

//트레이니 체크박스 뷰
class TraineeCheckBoxList extends StatefulWidget {
  const TraineeCheckBoxList({Key? key}) : super(key: key);

  @override
  State<TraineeCheckBoxList> createState() => _TraineeCheckBoxListState();
}

//트레이니 체크박스 위젯
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


