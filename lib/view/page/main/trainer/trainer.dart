import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

// 트레이너 메인 페이지
class TrainerMainPage extends StatelessWidget {
  const TrainerMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chevron_left,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    iconSize: 40,
                  ),
                ),
                Container(
                  // color: Colors.green,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 150,
                  child: FWText(
                    '삼손',
                    size: 20,
                  ),
                ),
                Container(
                  // color: Colors.red,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    iconSize: 40,
                  ),
                ),
              ],
            ),
          ),
          // CircularPercentIndicator(
          //   radius: 50.0,
          //   lineWidth: 10.0,
          //   percent: 0.2,
          //   header: const Text("Icon header"),
          //   center: Image.network(
          //     'https://t1.daumcdn.net/cfile/tistory/240814485574155029',
          //   ),
          //   backgroundColor: Colors.grey,
          //   progressColor: Colors.blue,
          // ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: SizedBox(
                height: 120,
                child: ListView(
                  children: <Widget>[
                    Row(
                      children: [
                        CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 10.0,
                          percent: 0.8,
                          center: ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(40), // Image radius
                              child: Image.network(
                                  'https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          reverse: true,
                          backgroundColor: Colors.grey,
                          progressColor: Colors.blue,
                        ),
                      ],
                    ),
                    // Card(
                    //   child: CircularPercentIndicator(
                    //     radius: 30.0,
                    //     lineWidth: 10.0,
                    //     percent: 0.8,
                    //     header: const Text("Icon header"),
                    //     center: const Icon(
                    //       Icons.person_pin,
                    //       size: 50.0,
                    //       color: Colors.blue,
                    //     ),
                    //     backgroundColor: Colors.grey,
                    //     progressColor: Colors.blue,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
