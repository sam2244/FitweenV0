import 'package:fitween1/presenter/page/detail.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

import '../../../model/plan/plan.dart';
import '../../../model/plan/todo.dart';

class PlanDetailPage extends StatelessWidget {
  final Plan plan;
  const PlanDetailPage({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TraineeInformation(plan: plan),
            const TraineeWeeklyCalendar(),
            TraineeExerciseCard(plan: plan),
          ],
        ),
      ),
    );
  }
}

class TraineeInformation extends StatelessWidget {
  final Plan plan;
  const TraineeInformation({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final difference = plan.endDate!.difference(plan.startDate!).inDays;

    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
      height: 124.0,
      child: Row(
        children: [
          const TraineeProfileImage(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FWText(
                  'D - $difference',
                  style: Theme.of(context).textTheme.titleSmall,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 8.0),
                FWText(
                  plan.trainee!.nickname!,
                  style: Theme.of(context).textTheme.titleMedium,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

class TraineeWeeklyCalendar extends StatelessWidget {
  const TraineeWeeklyCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainerDetailPresenter>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: WeeklyDatePicker(
            selectedDay: controller.selectedDay,
            changeDay: (selected) => controller.indexChanged(selected),
            selectedBackgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}

class TraineeExerciseCard extends StatelessWidget {
  final Plan plan;
  const TraineeExerciseCard({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Todo>? todoList;

    return GetBuilder<TrainerDetailPresenter>(
      builder: (controller) {
        print(plan.todos);
        todoList =
            plan.todos[controller.selectedDay.subtract(Duration(days: 1))];
        print(todoList);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FWText(
                    "운동",
                    style: Theme.of(context).textTheme.titleMedium,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  if (todoList != null)
                    for (int i = 0; i < todoList!.length; i++)
                      ListTile(
                        leading: Checkbox(
                          value: todoList![i].completed,
                          onChanged: (bool? value) {},
                          // onChanged: (value) =>
                          //     controller.checkboxState(i, value!),
                        ),
                        title: FWText(
                          todoList![i].toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                  const SizedBox(height: 8),
                  FWText(
                    "식단",
                    style: Theme.of(context).textTheme.titleMedium,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(
                    height: 104.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: 80.0,
                          margin:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.camera),
                        ),
                        Container(
                          width: 80.0,
                          margin:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.camera),
                        ),
                        Container(
                          width: 80.0,
                          margin:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.camera),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
