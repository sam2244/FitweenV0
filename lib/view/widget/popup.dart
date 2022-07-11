import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DialogType { info, warning }

class FWDialog extends StatelessWidget {
  FWDialog({
    Key? key,
    this.title,
    required this.child,
    this.leftLabel = '취소',
    this.rightLabel = '확인',
    this.leftPressed,
    required this.rightPressed,
    this.maxWidth = 300.0,
    this.maxHeight = 100.0,
    this.type = DialogType.info,
  }) : super(key: key);

  final String? title;
  final Widget child;
  final String leftLabel;
  final String rightLabel;
  VoidCallback? leftPressed;
  final VoidCallback rightPressed;
  final double maxWidth;
  final double maxHeight;
  final DialogType type;

  @override
  Widget build(BuildContext context) {
    leftPressed ??= Get.back;

    Map<DialogType, Color> colors = {
      DialogType.info: Theme.of(context).colorScheme.primary,
      DialogType.warning: Theme.of(context).colorScheme.error,
    };

    BorderRadius bottomLeftRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(20.0),
    );
    BorderRadius bottomRightRadius = const BorderRadius.only(
      bottomRight: Radius.circular(20.0),
    );

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
              ),
              child: Column(
                children: [
                  if (title != null)
                  Row(
                    children: [
                      FWText(title!,
                        style: Theme.of(context).textTheme.headlineSmall,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ],
                  ),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: FWTheme.surface[1],
                  borderRadius: bottomLeftRadius,
                  child: InkWell(
                    onTap: leftPressed,
                    borderRadius: bottomLeftRadius,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      child: Center(
                        child: FWText(
                          leftLabel,
                          style: Theme.of(context).textTheme.labelLarge,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: colors[type],
                  borderRadius: bottomRightRadius,
                  child: InkWell(
                    onTap: rightPressed,
                    borderRadius: bottomRightRadius,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      child: Center(
                        child: FWText(
                          rightLabel,
                          style: Theme.of(context).textTheme.labelLarge,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
