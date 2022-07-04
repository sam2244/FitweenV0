import 'dart:math' as math;

import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/model/user/range.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// 차트 기간 타입
enum PeriodType { days, weeks, months, years, all }

// 차트 모델
class Chart {
  Map<DateTime, double> data;
  ThemeData themeData;
  PeriodType type;

  Chart({
    required this.data,
    required this.themeData,
    this.type = PeriodType.days,
  });

  void setTheme(Theme theme) => theme = theme;

  /// date
  // 기간 타입에 따른 x 축 표시 범위
  Map<PeriodType, int> get range => {
    PeriodType.days: 7,
    PeriodType.weeks: 28,
    PeriodType.months: 84,
    PeriodType.years: 364,
    PeriodType.all: DateRange(
      start: data.keys.first,
      end: data.keys.last,
    ).range.toInt(),
  };

  // x 축 표시 범위 (DateRange)
  DateRange get dateRange {
    DateTime endDate = data.keys.last;
    DateTime startDate = endDate.subtract(Duration(days: range[type]!));

    if (data.keys.first.isAfter(startDate)) startDate = data.keys.first;
    return DateRange(start: startDate, end: endDate);
  }

  /// data
  // 화면에 보이지 않는 데이터를 제거한 데이터 값
  Map<DateTime, double> get slicedData {
    Map<DateTime, double> slicingData = {...data};
    List<DateTime> recentDates = slicingData.keys.toList().reversed.toList();
    DateTime? sliceDate = recentDates.firstWhereOrNull((key) => key.isBefore(dateRange.start));
    slicingData.removeWhere((key, value) => key.isBefore(sliceDate ?? data.keys.first));
    return slicingData;
  }

  /// weight
  // 체중의 최대 최소 및 범위 (slicedData 를 사용하여 화면에 표시되는 데이터에 맞게 y 축 범위 지정 가능)
  double get minWeight => slicedData.values.reduce(math.min);
  double get maxWeight => slicedData.values.reduce(math.max);
  WeightRange get weightRange => WeightRange(start: minWeight, end: maxWeight);


  /// axis
  // 그리드 선 출력 여부
  bool showHorizontalLine = true;
  bool showVerticalLine = false;

  // x 축의 간격
  int horizontalInterval = 2;

  // y 축의 간격 조건 (기간 타입에 따라 간격이 상이)
  bool verticalIntervalCondition(PeriodType type, DateTime date) {
    switch(type) {
      case PeriodType.days: return date.day % 2 == 0;
      case PeriodType.weeks: return [1, 10, 20].contains(date.day);
      case PeriodType.months: return date.day == 1;
      case PeriodType.years: return date.month % 3 == 1 && date.day == 1;
      case PeriodType.all: return date.month == 1 && date.day == 1;
    }
  }

  // 하단 x 축 레이블
  SideTitleWidget getBottomTitlesWidget(value, meta) {
    DateTime date = dateRange.getDate(value);
    String text = '';

    if (verticalIntervalCondition(type, date)) {
      initializeDateFormatting();
      switch(type) {
        case PeriodType.days:
          text = DateFormat('d(E)', 'ko').format(date); break;
        case PeriodType.weeks:
          text = DateFormat(
            date.day == 1 ? 'M월 d일' : 'd일',
          ).format(date); break;
        case PeriodType.months:
          text = DateFormat(
            date.month == 1 ? 'yy년 M월' : 'M월',
          ).format(date); break;
        case PeriodType.years:
          text = DateFormat(
            date.month == 1 ? 'yy년 M월' : 'M월',
          ).format(date); break;
        case PeriodType.all:
          text = DateFormat('yy년').format(date); break;
      }
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text),
    );
  }

  // 좌측 y 축 레이블
  SideTitleWidget getLeftTitlesWidget(value, meta) {
    double weight = value;
    String text = value % horizontalInterval == 0
        ? '${weight.toInt()}' : '';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text),
    );
  }

  /// dot
  // 점 출력 여부
  bool showDots = true;

  /// toolTip
  // 툴팁 위젯
  String getToolTipText(LineBarSpot spot) {
    const pattern = 'M월 d일 (E)';
    String x = DateFormat(pattern, 'ko').format(dateRange.getDate(spot.x));
    String y = '${spot.y} kg';
    return '$x\n$y';
  }

  // 전체 차트 데이터
  LineChartData get chartData {
    return LineChartData(
      clipData: FlClipData.all(),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          tooltipBgColor: themeData.colorScheme.primaryContainer,
          tooltipRoundedRadius: 20.0,
          getTooltipItems: (touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              return LineTooltipItem(
                getToolTipText(barSpot),
                themeData.textTheme.labelMedium ?? const TextStyle(),
              );
            }).toList();
          },
        ),
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: themeData.colorScheme.primary,
                strokeWidth: 2,
              ),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 5.5,
                    color: FWTheme.primary,
                    strokeWidth: 2,
                    strokeColor: themeData.colorScheme.primary,
                  );
                },
              ),
            );
          }).toList();
        },
      ),
      gridData: FlGridData(
        drawHorizontalLine: showHorizontalLine,
        drawVerticalLine: showVerticalLine,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: value % horizontalInterval == 0
                ? FWTheme.grey : Colors.transparent,
            strokeWidth: 1,
            dashArray: [4, 4],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: verticalIntervalCondition(type, dateRange.getDate(value))
                ? FWTheme.grey : Colors.transparent,
            strokeWidth: 1,
            dashArray: [4, 4],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getBottomTitlesWidget,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            getTitlesWidget: getLeftTitlesWidget,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border.symmetric(
          horizontal: BorderSide(
            color: FWTheme.grey,
            width: 1.2,
          ),
        ),
      ),
      minX: -(range[type]! ~/ 7).toDouble(),
      maxX: dateRange.getValue(dateRange.end) + range[type]! ~/ 7,
      minY: minWeight.floor() - 1,
      maxY: maxWeight.ceil() + 1,
      lineBarsData: [
        LineChartBarData(
          spots: data.entries.map((weight) => FlSpot(
            dateRange.getValue(weight.key),
            weight.value,
          )).toList(),
          isCurved: true,
          color: FWTheme.primary,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(show: showDots),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                FWTheme.primary.withOpacity(.7),
                FWTheme.primary.withOpacity(.1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
            ),
          ),
        ),
      ],
    );
  }

}