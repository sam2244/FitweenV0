import 'package:carousel_slider/carousel_controller.dart';
import 'package:fitween1/model/chat/chat.dart';
import 'package:fitween1/model/plan/diet.dart';
import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/model/plan/todo.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/add_plan/add_todo.dart';
import 'package:fitween1/presenter/page/add_plan/add_diet.dart';
import 'package:fitween1/view/page/add_plan/widget.dart';
import 'package:flutter/material.dart';
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
  static const List<String> titles = ['플랜추가', '기간설정', '주간루틴', '식단관리'];

  static const Duration shakeDuration = Duration(milliseconds: 500);

  static Curve transitionCurve = Curves.fastOutSlowIn;
  static const Duration transitionDuration = Duration(milliseconds: 300);

  static final purposeCont = TextEditingController();
  static final carouselCont = CarouselController();

  static final userPresenter = Get.find<UserPresenter>();
  static final planPresenter = Get.find<PlanPresenter>();
  static final addTodoPresenter = Get.find<AddTodoPresenter>();
  static final addDietPresenter = Get.find<AddDietPresenter>();

  void initialize() {
    pageIndex = 0;
    hintText = Plan.purposes.first;
    fieldActive = false;
    period = 1;

    selectedDays = [];
    todos = [];
    diets = [];

    initDates();
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
    if (pageIndex == 0) { Get.back(); }

    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexDecrease();
  }

  // 다음 버튼 클릭 트리거
  void nextPressed() {
    bool isLastPage = plan.isDiet && pageIndex == CarouselView.widgetCount - 1;
    isLastPage |= !plan.isDiet && pageIndex == CarouselView.widgetCount - 2;

    if (pageIndex == 1) initDates();
    if (pageIndex == 2) plan.endDate = Chat.fullTime(plan.endDate!);

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

  void complete() {
    plan.trainer = userPresenter.user;
    userPresenter.addPlan(plan);
    Get.offAllNamed('/main/trainer');
    planPresenter.updateDB();
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
    if (plan.startDate == null) {
      if (plan.endDate == null) { plan.startDate = Plan.today; }
      else { plan.startDate = plan.endDate; }
    }
    if (plan.endDate == null) {
      if (plan.startDate == null) { plan.endDate = Plan.today; }
      else { plan.endDate = plan.startDate; }
    }

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
    initDates();

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
    initDates();

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
    initDates();

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
      List<Todo> todos = getTodos([Plan.toWeekday(date)]);
      List<Todo> dailyTodos = [];

      for (Todo todo in todos) {
        if (todo.selectedDays.contains(Plan.toWeekday(date))) {
          dailyTodos.add(todo);
        }
      }
      plan.todos[date] = dailyTodos;
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
      for (Weekday day in selectedDays) {
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
      plan.diets[date] = getDiets([Plan.toWeekday(date)]);
      date = date.add(const Duration(days: 1));
    }
  }
}
