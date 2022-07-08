import 'package:fitween1/global/global.dart';
import 'package:fitween1/presenter/model/exercise.dart';
import 'package:fitween1/presenter/page/add_plan/add_todo.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:fitween1/view/widget/picker.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddTodoAppBar(),
      body: GetBuilder<AddTodoPresenter>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 77.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FWCard(
                  title: '운동을 입력하세요.',
                  height: 260.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: FWDropdownSearch(
                              hintText: '운동',
                              item: ExercisePresenter.exercises.map((data) => data.name).toList(),
                              selectedItem: controller.name,
                              onChanged: controller.nameSelected,
                              search: true,
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Expanded(
                            child: FWDropdownSearch(
                              enable: ExercisePresenter.unitsLength(controller.name) > 1,
                              hintText: controller.unitType ?? '단위',
                              selectedItem: controller.unitType,
                              item: ExercisePresenter.getExercise(controller.name)?.units,
                              onChanged: controller.unitSelected,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: {
                          '횟수': const CountPicker(),
                          '거리': const DistancePicker(),
                          '시간': const TimePicker(),
                        }[controller.unitType] ?? Container(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FWButton(
                        onPressed: controller.nextPressed,
                        text: '다음',
                        width: 120.0,
                        height: 45.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


class AddTodoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddTodoAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTodoPresenter>(
      builder: (controller) {
        return AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: controller.backPressed
          ),
          title: FWText('주간 루틴',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          elevation: 0.0,
        );
      },
    );
  }
}


class CountPicker extends StatelessWidget {
  const CountPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTodoPresenter>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FWNumberPicker(
              onChanged: (value) => controller.numberSelected(value, '회'),
              value: controller.numbers['회']!.toDouble(),
              maxValue: 999,
              decimalPlace: 0,
              itemWidth: 35.0,
            ),
            FWText('회',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        );
      },
    );
  }
}


class DistancePicker extends StatelessWidget {
  const DistancePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTodoPresenter>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                FWNumberPicker(
                  onChanged: (value) => controller.numberSelected(value, 'km'),
                  value: controller.numbers['km']!.toDouble(),
                  maxValue: 999,
                  decimalPlace: 0,
                  itemWidth: 35.0,
                ),
                FWText('km',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Row(
              children: [
                FWNumberPicker(
                  onChanged: (value) => controller.numberSelected(value * 100, 'm'),
                  value: controller.numbers['m']!.toDouble(),
                  maxValue: 900,
                  decimalPlace: 0,
                  itemWidth: 50.0,
                  step: 100.0,
                ),
                FWText('m',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class TimePicker extends StatelessWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTodoPresenter>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FWNumberPicker(
                  onChanged: (value) => controller.numberSelected(value, '시간'),
                  value: controller.numbers['시간']!.toDouble(),
                  maxValue: 23,
                  decimalPlace: 0,
                  itemWidth: 35.0,
                ),
                FWText('시간',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FWNumberPicker(
                  onChanged: (value) => controller.numberSelected(value, '분'),
                  value: controller.numbers['분']!.toDouble(),
                  maxValue: 59,
                  decimalPlace: 0,
                  itemWidth: 35.0,
                ),
                FWText('분',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FWNumberPicker(
                  onChanged: (value) => controller.numberSelected(value, '초'),
                  value: controller.numbers['초']!.toDouble(),
                  maxValue: 59,
                  decimalPlace: 0,
                  itemWidth: 35.0,
                ),
                FWText('초',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

