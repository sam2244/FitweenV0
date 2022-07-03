import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/presenter/global.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class FWNumberPicker extends StatelessWidget {
  const FWNumberPicker({
    Key? key,
    required this.onChanged,
    required this.value,
    this.label,
    this.axis = Axis.vertical,
    this.itemCount = 5,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.step = 1.0,
    this.decimalPlace = 1,
    this.itemWidth = 50.0,
    this.itemHeight = 20.0,
  }) : super(key: key);

  final Axis axis;
  final int itemCount;
  final String? label;
  final Function(int) onChanged;
  final double value;
  final double minValue;
  final double maxValue;
  final double step;
  final int decimalPlace;
  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    double fadeWidth = itemWidth * 4;
    double fadeHeight = itemHeight * 4;

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
                  FWTheme.surface[1]!.withOpacity(i.toDouble()),
                  FWTheme.surface[1]!.withOpacity((1 - i).toDouble()),
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
                  FWTheme.surface[1]!.withOpacity(i.toDouble()),
                  FWTheme.surface[1]!.withOpacity((1 - i).toDouble()),
                ],
              ),
            ),
          ),
        ),
      ],
    };

    return Stack(
      children: [
        Row(
          children: [
            NumberPicker(
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
              textMapper: (value) => (int.parse(value) * step)
                  .toStringAsFixed(decimalPlace),
              textStyle: Theme.of(context).textTheme.labelLarge,
              selectedTextStyle: Theme.of(context).textTheme.labelLarge?.merge(
                const TextStyle(color: FWTheme.primary, fontWeight: FontWeight.w700),
              ),
            ),
            FWText(label ?? '', color: Theme.of(context).primaryColor),
          ],
        ),
        for (int i = 0; i < 2; i++) blurWidget[axis]![i],
      ],
    );
  }
}


class FWCard extends StatelessWidget {
  const FWCard({
    Key? key,
    this.title,
    required this.child,
    this.height = 115.0,
    this.outline = false,
  }) : super(key: key);

  final String? title;
  final Widget child;
  final double height;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        // elevation: 0.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: outline
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
              FWText(
                title!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Expanded(child: child),
            ],
          ),
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
    return GetBuilder<Global>(
      builder: (controller) {
        return NavigationBar(
          selectedIndex: controller.navIndex,
          onDestinationSelected: controller.navigate,
          backgroundColor: FWTheme.surface[2]!,
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
