import 'package:carousel_slider/carousel_controller.dart';
import 'package:fitween1/model/chat/chat.dart';
import 'package:fitween1/model/plan/diet.dart';
import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/model/plan/todo.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/add_plan/add_todo.dart';
import 'package:fitween1/presenter/page/add_plan/add_diet.dart';
import 'package:fitween1/presenter/page/main/trainer.dart';
import 'package:fitween1/view/page/add_plan/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddPlanPresenter extends GetxController {
  int pageIndex = 0;
  List<bool> invalids = [false, false];
  String hintText = Plan.purposes.first;
  bool fieldActive = false;
  int period = 1;

  List<Weekday> selectedDays = [];
  List<Todo> todos = [];
  List<Diet> diets = [];

  Plan plan = planPresenter.plan;

  static const int max = 999;
  static const List<String> titles = ['플랜 추가', '기간 설정', '주간 루틴', '식단 관리', '플랜 코드'];

  static const Duration shakeDuration = Duration(milliseconds: 500);

  static Curve transitionCurve = Curves.fastOutSlowIn;
  static const Duration transitionDuration = Duration(milliseconds: 300);

  static final purposeCont = TextEditingController();
  static final carouselCont = CarouselController();

  static final userPresenter = Get.find<UserPresenter>();
  static final planPresenter = Get.find<PlanPresenter>();
  static final addTodoPresenter = Get.find<AddTodoPresenter>();
  static final addDietPresenter = Get.find<AddDietPresenter>();
  static final trainerPresenter = Get.find<TrainerPresenter>();

  void initialize() {
    initDates();
    pageIndex = 0;
    plan.purpose = Plan.purposes.first;
    hintText = plan.purpose!;
    fieldActive = false;
    period = 1;

    selectedDays = [];
    todos = [];
    diets = [];
  }

  // 현재 페이지 인덱스 증가
  void pageIndexIncrease() {
    if (pageIndex < CarouselView.widgetCount - 1) pageIndex++;
    update();
  }

  // 현재 페이지 인덱스 감소
  void pageIndexDecrease() {
    if (pageIndex > 0) pageIndex--;
    update();
  }

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    bool isLastPage = pageIndex == CarouselView.widgetCount - 1;

    if (pageIndex == 0) { Get.back(); }
    if (isLastPage) {
      if (!plan.isDiet) {
        carouselCont.jumpToPage(3);
        pageIndexDecrease();
      }
    }
    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexDecrease();
  }

  // 다음 버튼 클릭 트리거
  void nextPressed() {
    extendDiets();
    bool isLastPage = pageIndex == CarouselView.widgetCount - 1;
    if (pageIndex == 2) {
      plan.endDate = Chat.fullTime(plan.endDate!);
      if (!plan.isDiet) {
        carouselCont.jumpToPage(3);
        pageIndexIncrease();
      }
    }
    if (pageIndex == 3) plan.generatePlanId();
    if (isLastPage) {
      extendTodos(); extendDiets(); complete();
      pageIndex = 0;
      Get.offAllNamed('/main/trainer');
      return;
    }

    carouselCont.nextPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    selectedDays = [];
    pageIndexIncrease();
  }

  void complete() async {
    FWUser user = FWUser.fromMap(userPresenter.user.toMap());
    plan.trainer = FWUser.fromMap(user.toMap());
    plan.trainer!.trainerPlanIds.add(plan.id!);
    plan.trainerUid = user.uid;
    Get.offAllNamed('/main/trainer');
    UserPresenter.updateDB(plan.trainer!);
    PlanPresenter.updateDB(plan);
    await userPresenter.loadPlans();
    await planPresenter.loadTrainer();
    trainerPresenter.initialize();
    update();
  }

  void purposeSelected(String purpose) {
    plan.purpose = purpose;
    purposeCont.clear();
    hintText = purpose == '기타' ? '직접입력' : purpose;
    fieldActive = purpose == '기타';
    update();
  }

  void dietSelected(bool isDiet) {
    plan.isDiet = isDiet;
    update();
  }

  void initDates() {
    plan.startDate = Plan.today;
    plan.endDate = Plan.today;
    setPeriod();
  }

  void setPeriod() {
    period = plan.endDate!.difference(plan.startDate!).inDays + 1;
    update();
  }

  void syncStart() {
    if (plan.endDate!.isBefore(plan.startDate!)) {
      plan.startDate = plan.endDate;
    }
  }

  void syncEnd() {
    if (plan.startDate!.isAfter(plan.endDate!)) {
      plan.endDate = plan.startDate;
    }
  }

  void startDateSelected() async {
    Future<DateTime?> date = showDatePicker(
      context: Get.context!,
      initialDate: plan.startDate!,
      firstDate: Plan.today.subtract(const Duration(days: 30)),
      lastDate: Plan.today.add(const Duration(days: max)),
    );
    plan.startDate = await date;
    if (plan.startDate == null) return;

    syncEnd();
    setPeriod();
    update();
  }

  void endDateSelected() async {
    Future<DateTime?> date = showDatePicker(
      context: Get.context!,
      initialDate: plan.endDate!,
      firstDate: Plan.today.subtract(const Duration(days: 30)),
      lastDate: Plan.today.add(const Duration(days: max)),
    );
    plan.endDate = await date;
    if (plan.endDate == null) return;

    syncStart();
    setPeriod();
  }

  void periodSelected(int period) {
    this.period = period;
    plan.endDate = plan.startDate!.add(Duration(days: period - 1));

    update();
  }

  void periodIncreased() { if (period < max) period++; update(); }
  void periodDecreased() { if (period > 1) period--; update(); }

  void allDeselectDays() { selectedDays = []; update(); }

  String selectedDaysToString() {
    if (selectedDays.isEmpty) { return ''; }
    else if (selectedDays.length == 7) { return '매일'; }
    return '매 주 ${selectedDays.map((day) => '${day.kr}').join(',')}';
  }

  void weekdayToggled(Weekday day) {
    if (selectedDays.contains(day)) { selectedDays.remove(day); }
    else {
      selectedDays.add(day);
      selectedDays.sort((d1, d2) {
        List<Weekday> weekList = Weekday.values.toList();
        return weekList.indexOf(d1) - weekList.indexOf(d2);
      });
    }
    update();
  }

  void addTodoPressed() {
    if (selectedDays.isEmpty) return;
    addTodoPresenter.updateIndex = -1;
    addTodoPresenter.initialize();
    Get.toNamed('/addTodo');
  }

  void updateTodoPressed(Todo todo) {
    addTodoPresenter.updateIndex = todos.indexOf(todo);
    addTodoPresenter.initialize(todo);
    Get.toNamed('/addTodo');
  }

  void addTodo(Todo todo) { todos.add(todo); update(); }
  void updateTodo(Todo todo) {
    todos[addTodoPresenter.updateIndex] = todo;
    update();
  }

  void removeTodo(Todo todo) {
    todos.remove(todo);
    update();
  }

  List<Todo> getTodos(List<Weekday> days) {
    List<Todo> result = [];
    for (Todo todo in todos) {
      bool add = true;
      for (Weekday day in selectedDays) {
        if (!todo.selectedDays.contains(day)) add = false;
      }
      if (add && selectedDays.isNotEmpty) result.add(todo);
    }
    return result;
  }

  List<Todo> getTodosInSelectedDays() => getTodos(selectedDays);

  void extendTodos() {
    DateTime date = plan.startDate!;
    while (date.isBefore(plan.endDate!)) {
      List<Todo> dailyTodoList = [];

      for (Todo todo in todos) {
        if (todo.selectedDays.contains(Plan.toWeekday(date))) {
          dailyTodoList.add(todo);
        }
      }
      plan.todos[date] = dailyTodoList;
      date = date.add(const Duration(days: 1));
    }
  }

  void addDietPressed() {
    if (selectedDays.isEmpty) return;
    addDietPresenter.updateIndex = -1;
    addDietPresenter.initialize();
    Get.toNamed('/addDiet');
  }

  void updateDietPressed(Diet diet) {
    addDietPresenter.updateIndex = diets.indexOf(diet);
    addDietPresenter.initialize(diet);
    Get.toNamed('/addDiet');
  }

  void addDiet(Diet diet) { diets.add(diet); update(); }
  void updateDiet(Diet diet) {
    diets[addDietPresenter.updateIndex] = diet;
    update();
  }

  void removeDiet(Diet diet) {
    diets.remove(diet);
    update();
  }

  List<Diet> getDiets(List<Weekday> days, [String? type]) {
    List<Diet> result = [];
    for (Diet diet in diets) {
      bool add = true;
      for (Weekday day in diet.selectedDays) {
        if (!days.contains(day)) add = false;
      }
      if (add
          && selectedDays.isNotEmpty
          && (type == null || diet.type == type)
      ) result.add(diet);
    }
    return result;
  }

  List<Diet> getDietsInSelectedDays(String type) {
    return getDiets(selectedDays, type);
  }

  void extendDiets() {
    DateTime date = plan.startDate!;
    while (date.isBefore(plan.endDate!)) {
      List<Diet> dailyDietList = [];

      for (Diet diet in diets) {
        if (diet.selectedDays.contains(Plan.toWeekday(date))) {
          dailyDietList.add(diet);
        }
      }
      plan.diets[date] = dailyDietList;
      date = date.add(const Duration(days: 1));
    }
  }

  static void copyButtonPressed(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
