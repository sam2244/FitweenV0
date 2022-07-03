import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

// 트레이너 메인 페이지 CategoryBar
class TraineeCategory extends StatelessWidget {
  const TraineeCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.primary,
            ),
            iconSize: 40,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 150,
            child: FWText(
              '삼손',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
            iconSize: 40,
          ),
        ],
      ),
    );
  }
}

// 트레이너 메인 페이지 Card
class TraineeCard extends StatelessWidget {
  const TraineeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 108.0,
            child: Row(
              children: const [
                TraineeProfileImage(),
                Expanded(child: TraineeInfo()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 트레이너 메인 페이지 CategoryBar
class TraineeProfileImage extends StatelessWidget {
  const TraineeProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 10.0,
      percent: 0.8,
      center: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(40.0), // Image radius
          child: Image.network(
            'https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      reverse: true,
      backgroundColor: Colors.transparent,
      linearGradient: const LinearGradient(
        colors: [Color(0xffB07BE6), Color(0xff5BA2E0)],
      ),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}

// 트레이너 메인 페이지 Trainee Information
class TraineeInfo extends StatelessWidget {
  const TraineeInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TraineeName(name: '정윤석'),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                TrainerMainPageGraph(title: '운동', total: 5, completed: 4),
                if (true) // isDiet
                TrainerMainPageGraph(title: '식단', total: 3, completed: 2),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 트레이너 메인 페이지 CategoryBar
class TraineeName extends StatelessWidget {
  final String name;
  const TraineeName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FWText(
      name,
      color: Theme.of(context).colorScheme.onSurface,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}

// 트레이너 메인 페이지 CategoryBar
// class TrainerMainPageSubTitle extends StatelessWidget {
//   final String subtitle;
//   const TrainerMainPageSubTitle({Key? key, required this.subtitle})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue,
//       child: FWText(
//         subtitle,
//         color: Theme.of(context).colorScheme.onSurfaceVariant,
//         style: Theme.of(context).textTheme.labelSmall,
//       ),
//     );
//   }
// }

// 트레이너 메인 페이지 Graph
class TrainerMainPageGraph extends StatelessWidget {
  final String title;
  final int total;
  final int completed;

  const TrainerMainPageGraph({
    Key? key,
    required this.title,
    required this.completed,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FWText(
          title,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          lineHeight: 12,
          linearGradient: const LinearGradient(
            colors: <Color>[Color(0xffB07BE6), Color(0xff5BA2E0)],
          ),
          barRadius: const Radius.circular(10),
          percent: completed / total,
        ),
      ],
    );
  }
}

class TrainerView extends StatelessWidget {
  const TrainerView({Key? key}) : super(key: key);

  // // 회원가입 페이지 carousel 리스트
  // static List<Widget> carouselWidgets() => const [
  //   NicknameInputField(),
  //   RoleSelectionButtonView(),
  //   UserInfoView(),
  // ];
  // static int widgetCount = carouselWidgets().length;

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    // bool keyboardDisabled = WidgetsBinding.instance.window.viewInsets.bottom < 100.0;
    List<PlanCate> planCates = [
      const PlanCate(
        category: '삼손',
        trainees: [
          Trainee(
            name: '정윤석',
            total: 5,
            completed: 4,
          ),
          Trainee(
            name: '정윤석',
            total: 5,
            completed: 4,
          ),
          Trainee(
            name: '정윤석',
            total: 5,
            completed: 4,
          ),
        ],
      ),
      const PlanCate(
        category: '암스트롱',
        trainees: [
          Trainee(
            name: '정윤석',
            total: 5,
            completed: 4,
          ),
          Trainee(
            name: '정윤석',
            total: 5,
            completed: 4,
          ),
        ],
      ),
      const PlanCate(
        category: '청풍',
        trainees: [
          Trainee(
            name: '정윤석',
            total: 5,
            completed: 4,
          ),
          Trainee(
            name: '정윤석',
            total: 5,
            completed: 4,
          ),
          Trainee(
            name: '정윤석',
            total: 5,
            completed: 4,
          ),
          Trainee(
            name: '정윤석',
            total: 5,
            completed: 4,
          ),
        ],
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: const [
          TraineeCategory(),
          TraineeCard(),
        ],
      ),
    );
  }
}

class PlanCate {
  final String category;
  final List<Trainee> trainees;

  const PlanCate({
    required this.category,
    required this.trainees,
  });
}

class Trainee {
  final String name;
  final int total;
  final int completed;

  const Trainee({
    required this.name,
    required this.total,
    required this.completed,
  });
}
