import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/global.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/page/chat/chat/widget.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> map = {
      'imageUrl': UserPresenter.defaultProfile,
      'role': Role.trainee,
      'height': FWUser.defaultHeight,
      'statusMessage': 'ㄴr는 ㄱr끔 눈물을 흘린ㄷr...\n세계 최고 트레이너',
      'categories': <String>[],
      'trainerPlanIds': <String>[],
      'traineePlanIds': <String>[],
      'friendUids': <String>[],
    };

    map['nickname'] = '이하준';
    Map<String, dynamic> map1 = {...map};
    map['nickname'] = '정윤석';
    Map<String, dynamic> map2 = {...map};
    map['nickname'] = '최복원';
    Map<String, dynamic> map3 = {...map};
    map['nickname'] = '한상윤';
    Map<String, dynamic> map4 = {...map};
    map['nickname'] = '현승준';
    Map<String, dynamic> map5 = {...map};

    List<FWUser> friends = [
      FWUser.fromMap(map1),
      FWUser.fromMap(map2),
      FWUser.fromMap(map3),
      FWUser.fromMap(map4),
      FWUser.fromMap(map5),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const ChatAppBar(),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => GlobalPresenter.profilePressed(friends[index]),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 20.0,
              ),
              leading: ProfileImageCircle(user: friends[index]),
              title: FWText(
                friends[index].nickname!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const FWBottomBar(),
    );
  }
}
