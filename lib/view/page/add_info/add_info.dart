import 'package:fitween1/presenter/page/add_info.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInfoPage extends StatelessWidget {
  const AddInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> nullData = Get.arguments;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: GetBuilder<AddInfoPresenter>(
        builder: (controller) {
          controller.initControllers(nullData);
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(title: const Text('추가정보 입력')),
            body: Container(
              color: Theme.of(context).colorScheme.onPrimary,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: nullData.map((data) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Container(
                              width: 120.0,
                              alignment: Alignment.center,
                              child: Text(data),
                            ),
                            Expanded(
                              child: FWInputField(
                                controller: controller.getController(data)!,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                    ElevatedButton(
                      onPressed: controller.nextPressed,
                      child: const Text('다음'),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}