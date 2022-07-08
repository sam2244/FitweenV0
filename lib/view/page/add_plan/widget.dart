import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/presenter/page/add_plan/add_diet.dart';
import 'package:fitween1/presenter/page/add_plan/add_plan.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DateType { start, end }

class AddPlanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddPlanAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanPresenter>(
      builder: (controller) {
        return AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: controller.backPressed
          ),
          title: FWText(
            AddPlanPresenter.titles[controller.pageIndex],
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          elevation: 0.0,
        );
      },
    );
  }
}

// Carousel 뷰 위젯
class CarouselView extends StatelessWidget {
  const CarouselView({Key? key}) : super(key: key);


  // 플랜 추가 페이지 carousel 리스트
  static List<Widget> carouselWidgets() => [
    const PurposeDietView(),
    const PTPeriodView(),
    const RoutineSelectionView(),
    const DietSelectionView(),
  ];
  static int widgetCount = carouselWidgets().length;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool keyboardDisabled = WidgetsBinding.instance.window.viewInsets.bottom < 100.0;

    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 20.0),
            alignment: Alignment.topCenter,
            child: Container(
              constraints: BoxConstraints(minWidth: screenSize.width),
              child: CarouselSlider(
                carouselController: AddPlanPresenter.carouselCont,
                items: carouselWidgets().map((widget) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: widget,
                )).toList(),
                options: CarouselOptions(
                  height: double.infinity,
                  initialPage: 0,
                  reverse: false,
                  enableInfiniteScroll: false,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  viewportFraction: 1.0,
                  // onPageChanged: controller.pageChanged,
                ),
              ),
            ),
          ),
        ),
        GetBuilder<AddPlanPresenter>(
          builder: (controller) {
            return Container(
              height: keyboardDisabled ? 200.0 : 100.0,
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Carousel 인디케이터
                  CarouselIndicator(
                    count: widgetCount - (controller.plan.isDiet ? 0 : 1),
                  ),
                  // Carousel 다음 버튼
                  const CarouselNextButton(),
                ],
              ),
            );
          }
        ),
      ],
    );
  }
}

class PurposeDietView extends StatelessWidget {
  const PurposeDietView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = [
      FWCard(
        height: 190.0,
        title: '트레이닝의 목적이 무엇인가요?',
        child: GetBuilder<AddPlanPresenter>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                DropdownSearch<String>(
                  items: Plan.purposes,
                  onChanged: (value) => controller.purposeSelected(value ?? ''),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      border: const OutlineInputBorder(),
                      labelText: '목적',
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      hintStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  dropdownBuilder: (context, purpose) => FWText(
                    purpose ?? '다이어트',
                    style: Theme.of(context).textTheme.labelLarge,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  popupProps: PopupProps.menu(
                    fit: FlexFit.loose,
                    listViewProps: const ListViewProps(itemExtent: 48.0),
                    menuProps: MenuProps(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      animationDuration: Duration.zero,
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      shadowColor: Theme.of(context).colorScheme.shadow,
                    ),
                    itemBuilder: (context, purpose, _) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(left: 15.0),
                        selected: purpose == AddPlanPresenter.planPresenter.plan.purpose,
                        tileColor: FWTheme.surface[2],
                        selectedTileColor: Color.alphaBlend(
                          Theme.of(context).colorScheme.onSurface.withOpacity(.12),
                          FWTheme.surface[2]!,
                        ),
                        title: FWText(
                          purpose,
                          style: Theme.of(context).textTheme.labelLarge,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12.0),
                FWInputField(
                  controller: AddPlanPresenter.purposeCont,
                  hintText: controller.hintText,
                  enabled: controller.fieldActive,
                ),
              ],
            ),
          ),
        ),
      ),
      FWCard(
        height: 116.0,
        title: '피트위너의 식단을 관리하시겠습니까?',
        child: GetBuilder<AddPlanPresenter>(
          builder: (controller) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FWButton(
                text: '예',
                fill: AddPlanPresenter.planPresenter.plan.isDiet,
                width: 132.0,
                onPressed: () => controller.dietSelected(true),
              ),
              FWButton(
                text: '아니오',
                width: 132.0,
                fill: !AddPlanPresenter.planPresenter.plan.isDiet,
                onPressed: () => controller.dietSelected(false),
              ),
            ],
          ),
        ),
      ),
    ];

    return ListView.separated(
      itemCount: contents.length,
      itemBuilder: (context, index) => contents[index],
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
    );
  }
}

class PTPeriodView extends StatelessWidget {
  const PTPeriodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FWCard(
          title: '트레이닝 기간을 선택해주세요.',
          height: 310.0,
          child: Column(
            children: [
              const DateSelectionButton(type: DateType.start),
              const DateSelectionButton(type: DateType.end),
              Divider(
                height: 30.0,
                color: Theme.of(context).colorScheme.outline,
              ),
              const PeriodSelectionButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class DateSelectionButton extends StatelessWidget {
  const DateSelectionButton({Key? key, required this.type}) : super(key: key);

  final DateType type;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanPresenter>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FWText({
                  DateType.start: '시작일', DateType.end: '종료일',
                }[type]!,
                style: Theme.of(context).textTheme.labelLarge,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: {
                      DateType.start: controller.startDateSelected,
                      DateType.end: controller.endDateSelected,
                    }[type]!,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      child: Stack(
                        children: [
                          const Positioned(
                            right: 8.0,
                            child: Icon(Icons.calendar_month),
                          ),
                          Positioned(
                            child: Center(
                              child: FWText(
                                Plan.dateToString((
                                    type == DateType.start
                                        ? AddPlanPresenter.planPresenter.plan.startDate
                                        : AddPlanPresenter.planPresenter.plan.endDate
                                ) ?? Plan.today),
                                style: Theme.of(context).textTheme.labelLarge,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}

class PeriodSelectionButton extends StatelessWidget {
  const PeriodSelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanPresenter>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FWText(
              '총 기간',
              style: Theme.of(context).textTheme.labelLarge,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: controller.periodDecreased,
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 10.0,
                  splashRadius: 25.0,
                ),
                FWNumberPicker(
                  itemCount: 5,
                  minValue: 1,
                  maxValue: AddPlanPresenter.max.toDouble(),
                  value: controller.period.toDouble(),
                  onChanged: controller.periodSelected,
                  axis: Axis.horizontal,
                  decimalPlace: 0,
                  itemWidth: 35.0,
                ),
                IconButton(
                  onPressed: controller.periodIncreased,
                  icon: const Icon(Icons.arrow_forward_ios),
                  iconSize: 10.0,
                  splashRadius: 25.0,
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}


class RoutineSelectionView extends StatelessWidget {
  const RoutineSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanPresenter>(
      builder: (controller) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: Weekday.values.map((day) => WeekdayButton(day: day)).toList(),
            ),
            FWCard(
              height: 300.0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const InitializeSelectionButton(),
                      FWText(
                        controller.selectedDaysToString(),
                        style: Theme.of(context).textTheme.labelMedium,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ],
                  ),
                  Divider(
                    height: 40.0,
                    thickness: 5.0,
                    color: FWTheme.surface[2],
                  ),
                  const TodoListView(),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}

class InitializeSelectionButton extends StatelessWidget {
  const InitializeSelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanPresenter>(
      builder: (controller) {
        return InkWell(
          onTap: controller.allDeselectDays,
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            children: [
              FWText(
                '선택 초기화',
                style: Theme.of(context).textTheme.labelSmall,
                color: Theme.of(context).colorScheme.outline,
              ),
              Icon(
                Icons.restart_alt,
                size: 12.0,
                color: Theme.of(context).colorScheme.outline,
              ),
            ],
          ),
        );
      }
    );
  }
}

class WeekdayButton extends StatelessWidget {
  const WeekdayButton({
    Key? key,
    required this.day,
  }) : super(key: key);

  final Weekday day;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanPresenter>(
      builder: (controller) {
        return Material(
          color: controller.selectedDays.contains(day)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(50.0),
          child: InkWell(
            onTap: () => controller.weekdayToggled(day),
            borderRadius: BorderRadius.circular(50.0),
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: Center(
                child: FWText(
                  day.kr,
                  style: Theme.of(context).textTheme.titleLarge,
                  color: controller.selectedDays.contains(day)
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanPresenter>(
      builder: (controller) {
        return Column(
          children: [
            SizedBox(
              height: 180.0,
              child: ListView(
                children: controller.getTodosInSelectedDays().map((todo) => InkWell(
                  onTap: () => controller.updateTodoPressed(todo),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FWText(todo.selectedDays.length == 7 ? '매일'
                            : todo.selectedDays.map((day) => day.kr).join(','),
                          style: Theme.of(context).textTheme.labelSmall,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        FWText(todo.toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      onPressed: () => controller.removeTodo(todo),
                    ),
                  ),
                )).toList(),
              ),
            ),
            Divider(
              height: 0.0,
              thickness: 2.0,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            AddButton(text: '루틴 추가', onPressed: controller.addTodoPressed),
          ],
        );
      }
    );
  }
}

class DietSelectionView extends StatelessWidget {
  const DietSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanPresenter>(
      builder: (controller) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: Weekday.values.map((day) => WeekdayButton(day: day)).toList(),
            ),
            FWCard(
              height: 410.0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const InitializeSelectionButton(),
                      FWText(
                        controller.selectedDaysToString(),
                        style: Theme.of(context).textTheme.labelMedium,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ],
                  ),
                  Divider(
                    height: 40.0,
                    thickness: 5.0,
                    color: FWTheme.surface[2],
                  ),
                  const DietListView(),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class DietListView extends StatelessWidget {
  const DietListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanPresenter>(
      builder: (controller) {
        return Column(
          children: [
            SizedBox(
              height: 280.0,
              child: ListView(
                children: AddDietPresenter.types.map((type) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.getDietsInSelectedDays(type).isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: FWText(type,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Column(
                      children: controller.getDietsInSelectedDays(type).map((diet) => InkWell(
                        onTap: () => controller.updateDietPressed(diet),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // FWText(diet.selectedDays.length == 7 ? '매일'
                              //     : diet.selectedDays.map((day) => day.kr).join(','),
                              //   style: Theme.of(context).textTheme.labelSmall,
                              //   color: Theme.of(context).colorScheme.outline,
                              // ),
                              FWText(diet.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            onPressed: () => controller.removeDiet(diet),
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                )).toList(),
              ),
            ),
            Divider(
              height: 0.0,
              thickness: 2.0,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            AddButton(text: '식단 추가', onPressed: controller.addDietPressed),
          ],
        );
      },
    );
  }
}


class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_circle_outline, size: 20.0),
          const SizedBox(width: 10.0),
          FWText(text,
            style: Theme.of(context).textTheme.headlineSmall,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

// Carousel 인디케이터 위젯
class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanPresenter>(
        builder: (controller) {
          return SizedBox(
            height: 100.0,
            child: DotsIndicator(
              dotsCount: count,
              position: controller.pageIndex.toDouble(),
              decorator: DotsDecorator(
                color: FWTheme.grey,
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }
    );
  }
}

// Carousel 다음 버튼
class CarouselNextButton extends StatelessWidget {
  const CarouselNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPlanPresenter>();

    return FWButton(
      onPressed: () {
        controller.nextPressed();
        FocusScope.of(context).unfocus();
      },
      text: '다음',
      width: 120.0,
      height: 45.0,
    );
  }
}