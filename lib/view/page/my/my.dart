import 'package:fitween1/view/page/my/widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text("사진"),
            ),
            Container(
              child: Text("닉네임"),
            ),
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                  child: LineChart(
                    mainChart(),
                  ),
                ),
              ),
            ),
            Container(
              child: Text("체중 변화 기록 차트"),
            ),
            Row(
              children: [
                Container(
                  child: Text("키"),
                ),
                Container(
                  child: Text("190"),
                ),
                Container(
                  child: Text("cm"),
                ),
              ],
            )
          ],
        ),
      )
    );
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
      /*titlesData: FlTitlesData(
        show: true,
        leftTitles: ,
        bottomTitles: ,
      ),*/
      /*titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            print('bottomTitles $value');
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            print('leftTitles $value');
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),*/
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
            FlSpot(1, 50),
            FlSpot(2, 52),
            FlSpot(3, 48),
            FlSpot(4, 47),
            FlSpot(5, 45),
            FlSpot(6, 47),
            FlSpot(7, 47),
            FlSpot(8, 45),
            FlSpot(8, 46),
            FlSpot(9, 47),
            FlSpot(10, 45),
          ],
          isCurved: true,
          color: Colors.red,
          barWidth: 5,
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
