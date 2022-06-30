import 'package:fitween1/view/page/my/widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitween1/view/widget/text.dart';

// 마이 페이지
class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            child: Text("사진 자리"),
          ),
          Container(
            child: FWText(
              '닉네임',
              size: 20.0,
              color: Colors.black,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left:30),
              child: FWText(
                '체중',
                size: 20.0,
                color: Colors.black,
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white),*/
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: LineChart(
                  mainChart(),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: FWText(
              '체중 변화 기록',
              size: 20.0,
              color: Colors.black,
            ),
          ),
          Container(
            child: FWText(
              "키" + " 190 " + "cm",
              size: 20.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '30';
        break;
      case 3:
        text = '50';
        break;
      case 5:
        text = '70';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainChart() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        //show가 true일 경우 밑에 Drawing Line 설정 주석 지우기
        /*getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },*/
      ),
      titlesData: FlTitlesData(
        show: true,
       /*bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),*/
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black, width: 1)),
      minX: 1,
      maxX: 10,
      minY: 30,
      maxY: 150,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, 55),
            FlSpot(2, 52.1),
            FlSpot(3, 49.7),
            FlSpot(4, 47.4),
            FlSpot(5, 46.2),
            FlSpot(6, 47.1),
            FlSpot(7, 46.0),
            FlSpot(8, 45.7),
            FlSpot(8, 46.1),
            FlSpot(9, 47.0),
            FlSpot(10, 45.2),
          ],
          isCurved: true,
          color: Colors.red,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
