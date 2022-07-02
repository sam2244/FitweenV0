import 'package:fitween1/view/page/add_plan/widget.dart';
import 'package:flutter/material.dart';

// 플랜 추가 페이지
class AddPlanPage extends StatelessWidget {
  const AddPlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: const AddPlanAppBar(),
        body: const CarouselView(),
      ),
    );
  }
}