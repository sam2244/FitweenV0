import 'package:fitween1/presenter/global.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class FWNumberPicker extends StatelessWidget {
  FWNumberPicker({
    Key? key,
    required this.onChanged,
    required this.value,
    this.axis = Axis.vertical,
    this.itemCount = 5,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.step = 1.0,
    this.decimalPlace = 1,
    this.itemWidth = 50.0,
    this.itemHeight = 20.0,
    this.surfaceColor,
  }) : super(key: key);

  final Axis axis;
  final int itemCount;
  final Function(int) onChanged;
  final double value;
  final double minValue;
  final double maxValue;
  final double step;
  final int decimalPlace;
  final double itemWidth;
  final double itemHeight;
  Color? surfaceColor;

  @override
  Widget build(BuildContext context) {
    double fadeWidth = itemWidth * 4;
    double fadeHeight = itemHeight * 4;
    surfaceColor ??= Theme.of(context).colorScheme.background;

    Map<Axis, List<Widget>> blurWidget = {
      Axis.vertical: [
        for (int i = 0; i < 2; i++)
        Positioned.fill(
          top: fadeHeight * (1 - i),
          bottom: fadeHeight * i,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  surfaceColor!.withOpacity(i.toDouble()),
                  surfaceColor!.withOpacity((1 - i).toDouble()),
                ],
              ),
            ),
          ),
        ),
      ],
      Axis.horizontal: [
        for (int i = 0; i < 2; i++)
        Positioned.fill(
          left: fadeWidth * (1 - i),
          right: fadeWidth * i,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  surfaceColor!.withOpacity(i.toDouble()),
                  surfaceColor!.withOpacity((1 - i).toDouble()),
                ],
              ),
            ),
          ),
        ),
      ],
    };

    return Center(
      child: Stack(
        children: [
          Positioned(
            child: NumberPicker(
              axis: axis,
              itemCount: itemCount,
              haptics: true,
              onChanged: onChanged,
              value: value ~/ step,
              minValue: minValue ~/ step,
              maxValue: maxValue ~/ step,
              step: 1,
              itemWidth: itemWidth,
              itemHeight: itemHeight,
              textMapper: (value) => (int.parse(value) * step).toStringAsFixed(decimalPlace),
              textStyle: Theme.of(context).textTheme.labelLarge,
              selectedTextStyle: Theme.of(context).textTheme.labelLarge?.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          for (int i = 0; i < 2; i++) blurWidget[axis]![i],
        ],
      ),
    );
  }
}


class FWCard extends StatelessWidget {
  const FWCard({
    Key? key,
    this.title,
    required this.child,
    this.outline = false,
  }) : super(key: key);

  final String? title;
  final Widget child;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: outline
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
            FWText(title!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            child,
          ],
        ),
      ),
    );
  }
}


// 하단 네비게이션 바
class FWBottomBar extends StatelessWidget {
  const FWBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalPresenter>(
      builder: (controller) {
        return NavigationBar(
          selectedIndex: controller.navIndex,
          onDestinationSelected: controller.navigate,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_outlined),
              selectedIcon: Icon(Icons.chat),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_outlined),
              selectedIcon: Icon(Icons.account_circle),
              label: 'MyPage',
            ),
          ],
        );
      }
    );
  }
}
