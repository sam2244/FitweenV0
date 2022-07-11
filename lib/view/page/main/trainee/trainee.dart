import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/view/page/main/trainee/widget.dart';
import 'package:fitween1/view/page/main/widget.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:flutter/material.dart';

// 피트위너 메인 페이지
class TraineeMainPage extends StatelessWidget {
  const TraineeMainPage({Key? key}) : super(key: key);

  //Expanded FAB를 위한 function
  static const _actionTitles = ['Open Camera', 'Upload Photo'];

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  //Trainee Main Page View
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MainAppBar(role: Role.trainee),
      body: const TraineeView(),
      floatingActionButton: ExpandableFab(
        distance: 80.0,
        children: [
          ActionButton(
            onPressed: () => _showAction(context, 0),
            icon: const Icon(Icons.add_a_photo_outlined),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.photo_library_outlined),
          ),
        ],
      ),
      bottomNavigationBar: const FWBottomBar(),
    );
  }
}
