import 'package:fitween1/presenter/page/detail.dart';
import 'package:fitween1/view/page/main/trainer/widget.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class TraineeInfo extends StatelessWidget {
  final Trainee trainee;
  const TraineeInfo({Key? key, required this.trainee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainerDetailPresenter>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
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
                            'D - 60',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8.0),
                          FWText(
                            trainee.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: WeeklyDatePicker(
                  selectedDay: controller.selectedDay,
                  changeDay: (selected) => controller.indexChanged(selected),
                  // selectedBackgroundColor: Colors.amberAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
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
                        ListTile(
                          leading: Checkbox(
                            value: controller.checkedState,
                            onChanged: (value) =>
                                controller.checkboxToggle(value!),
                          ),
                          title: FWText(
                            '윗몸 일으키기',
                            style: Theme.of(context).textTheme.bodyLarge,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        ListTile(
                          leading: Checkbox(
                            value: controller.checkedState,
                            onChanged: (value) =>
                                controller.checkboxToggle(value!),
                          ),
                          title: FWText(
                            '윗몸 일으키기',
                            style: Theme.of(context).textTheme.bodyLarge,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        ListTile(
                          leading: Checkbox(
                            value: controller.checkedState,
                            onChanged: (value) =>
                                controller.checkboxToggle(value!),
                          ),
                          title: FWText(
                            '윗몸 일으키기',
                            style: Theme.of(context).textTheme.bodyLarge,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
