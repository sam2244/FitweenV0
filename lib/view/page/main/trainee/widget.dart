import 'package:fitween1/global/palette.dart';
import 'package:fitween1/model/plan/exercise.dart';
import 'package:fitween1/model/plan/todo.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 피트위너 메인 페이지의 위젯 모음

// 상단 프로필 위젯
class TopProfile extends StatelessWidget {
  const TopProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserPresenter userPresenter = Get.find<UserPresenter>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileImageCircle(user: userPresenter.user, size: 90.0),
        const SizedBox(height: 10.0),
        const FWText('스티브', size: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FWText('#5kg감량', size: 12, color: Palette.grey),
            SizedBox(width: 5.0),
            FWText('#BMI25', size: 12, color: Palette.grey),
          ],
        )
      ],
    );
  }
}

// 플랜 탭 바 위젯
class PlanTabBar extends StatefulWidget {
  const PlanTabBar({Key? key}) : super(key: key);

  @override
  State<PlanTabBar> createState() => _PlanTabBarState();
}
class _PlanTabBarState extends State<PlanTabBar> with TickerProviderStateMixin {
  late TabController tabCont;

  @override
  void initState() {
    tabCont = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> tabBars = [
      Container(
        width: 80.0,
        alignment: Alignment.center,
        child: const FWText('전체보기', weight: FWFontWeight.thin),
      ),
    ];

    tabBars.addAll(
      List.generate(5, (index) => Container(
        width: 80.0,
        alignment: Alignment.center,
        child: FWText('플랜${index + 1}', weight: FWFontWeight.thin),
      )),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Palette.grey,
                  width: 1.0,
                ),
              ),
            ),
            child: TabBar(
              controller: tabCont,
              indicatorColor: Palette.dark,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              tabs: tabBars,
            ),
          ),
        ),
        Material(
          color: Palette.grey,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.black.withOpacity(.2),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 60.0,
                height: 30.0,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: const Center(
                  child: FWText(
                    '+ 새 플랜',
                    size: 12.0,
                    weight: FWFontWeight.thin,
                    color: Palette.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 할일 목록
class TodoListView extends StatefulWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  State<TodoListView> createState() => _TodoListViewState();
}
class _TodoListViewState extends State<TodoListView> {
  List<Todo> todos = [
    Todo(exercise: Exercise(name: '푸시업'), countPerSet: 20),
    Todo(exercise: Exercise(name: '풀업'), countPerSet: 10),
    Todo(exercise: Exercise(name: '싯업'), countPerSet: 20, setCount: 3),
    Todo(exercise: Exercise(name: '스쿼트'), countPerSet: 10),
    Todo(exercise: Exercise(name: '크런치'), countPerSet: 50, setCount: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Palette.grey,
          ),
        ),
      ),
      child: Scrollbar(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  todos[index].toggleComplete();
                  setState(() {});
                },
                child: ListTile(
                  dense: true,
                  leading: Icon(
                    todos[index].completed
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Palette.dark,
                  ),
                  minLeadingWidth: 0.0,
                  title: FWText(todos[index].toString()),
                ),
              );
            }
        ),
      ),
    );
  }
}

// 식단 이미지 리스트
class DietCardView extends StatelessWidget {
  const DietCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 95.0,
      child: ListView.separated(
        itemCount: 3,
        itemBuilder: (context, index) => Material(
          borderRadius: BorderRadius.circular(15.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 95.0,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                border: Border.all(color: Palette.grey),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 30.0,
                color: Palette.grey,
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10.0),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}