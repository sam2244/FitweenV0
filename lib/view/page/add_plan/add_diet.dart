import 'package:fitween1/global/global.dart';
import 'package:fitween1/presenter/page/add_plan/add_diet.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:fitween1/view/widget/picker.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDietPage extends StatelessWidget {
  const AddDietPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddDietAppBar(),
      body: GetBuilder<AddDietPresenter>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 77.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FWCard(
                  title: '식단을 입력하세요.',
                  height: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: FWInputField(
                              controller: AddDietPresenter.dietCont,
                              hintText: '식단',
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Expanded(
                            child: FWDropdownSearch(
                              hintText: controller.diet!.type,
                              selectedItem: controller.diet?.type,
                              item: AddDietPresenter.types,
                              onChanged: controller.typeSelected,
                            ),
                          ),
                        ],
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

class AddDietAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddDietAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDietPresenter>(
      builder: (controller) {
        return AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: controller.backPressed
          ),
          title: FWText('식단 관리',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          elevation: 0.0,
        );
      },
    );
  }
}
