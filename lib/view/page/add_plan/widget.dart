import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/presenter/page/add_plan.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

enum DateType { start, end }

class AddPlanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddPlanAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GetBuilder<AddPlanPresenter>(
        builder: (controller) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: controller.backPressed,
          );
        }
      ),
      title: FWText('플랜 추가', size: 20.0),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      elevation: 0.0,
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
            padding: const EdgeInsets.only(top: 50.0),
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
        Container(
          height: keyboardDisabled ? 200.0 : 100.0,
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Carousel 인디케이터
              CarouselIndicator(count: widgetCount),
              // Carousel 다음 버튼
              const CarouselNextButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class PurposeDietView extends StatelessWidget {
  const PurposeDietView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> contents = {
      '목적': GetBuilder<AddPlanPresenter>(
        builder: (controller) => Row(
          children: [
            SizedBox(
              width: 80.0,
              child: DropdownButton<String>(
                value: AddPlanPresenter.planPresenter.plan.purpose,
                style: Theme.of(context).textTheme.labelLarge,
                items: Plan.purposes.map((purpose) => DropdownMenuItem<String>(
                  value: purpose,
                  child: Center(child: Text(purpose)),
                )).toList(),
                onChanged: (purpose) => controller.purposeSelected(purpose ?? ''),
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: FWInputField(
                controller: AddPlanPresenter.purposeCont,
                hintText: controller.hintText,
                enabled: controller.fieldActive,
              ),
            ),
          ],
        ),
      ),
      '식단': GetBuilder<AddPlanPresenter>(
        builder: (controller) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => controller.dietSelected(
                !AddPlanPresenter.planPresenter.plan.isDiet,
              ),
              child: FWText(
                '식단을 관리 하시겠습니까?',
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Checkbox(
              value: AddPlanPresenter.planPresenter.plan.isDiet,
              onChanged: (isDiet) => controller.dietSelected(isDiet ?? false),
            ),
          ],
        ),
      ),
    };

    return ListView.separated(
      itemCount: contents.length,
      itemBuilder: (context, index) => FWCard(
        height: 140.0,
        title: contents.keys.toList()[index],
        child: contents[contents.keys.toList()[index]]!,
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 20.0),
    );
  }
}

class PTPeriodView extends StatelessWidget {
  const PTPeriodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> contents = {
      'PT 시작일': const DateSelectionButton(type: DateType.start),
      'PT 종료일': const DateSelectionButton(type: DateType.end),
      '기간': PeriodSelectionButton(),
    };

    return ListView.separated(
      itemCount: contents.length,
      itemBuilder: (context, index) => FWCard(
        height: 100.0,
        title: contents.keys.toList()[index],
        child: Center(child: contents[contents.keys.toList()[index]]!),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 20.0),
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FWButton(
              onPressed: type == DateType.start
                  ? controller.startDateDecreased
                  : controller.endDateDecreased,
              text: '-',
              width: 40.0,
              fill: false,
            ),
            TextButton(
              onPressed: type == DateType.start
                  ? controller.startDateSelected
                  : controller.endDateSelected,
              child: Text(
                Plan.dateToString((
                  type == DateType.start
                      ? AddPlanPresenter.planPresenter.plan.startDate
                      : AddPlanPresenter.planPresenter.plan.endDate
                ) ?? Plan.today),
              ),
            ),
            FWButton(
              onPressed: type == DateType.start
                  ? controller.startDateIncreased
                  : controller.endDateIncreased,
              text: '+',
              width: 40.0,
              fill: false,
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FWButton(
              onPressed: controller.periodDecreased,
              text: '-',
              width: 40.0,
              fill: false,
            ),
            NumberPicker(
              itemCount: 5,
              minValue: 1,
              maxValue: 1000,
              value: controller.period,
              onChanged: controller.periodSelected,
              axis: Axis.horizontal,
              itemWidth: 40.0,
            ),
            FWButton(
              onPressed: controller.periodIncreased,
              text: '+',
              width: 40.0,
              fill: false,
            ),
          ],
        );
      }
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
      width: 120.0,
      height: 45.0,
      text: '다음',
    );
  }
}