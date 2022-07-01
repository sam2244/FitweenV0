import 'package:fitween1/view/page/my/widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// 마이 페이지
class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  File? _image;
  String imgData = "";
  var _user;
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  // Pick an image
  //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
                color: Color(0xFF38597E),
                borderRadius:
                BorderRadius.all(Radius.circular(100)) //모서리를 둥글게
            ),
            child: IconButton(
              icon: (imgData == "")
                  ? const Icon(Icons.person)
                  : Image.network(imgData),
              color: Colors.white,
              iconSize: 45.0,
              onPressed: () => selectDialog(),
            ),
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
            margin: const EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
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
  void selectDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: const <Widget>[
                Text("이미지 선택"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  "이미지를 가져올 곳을 선택해주세요.",
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("갤러리"),
                onPressed: () {
                  Navigator.pop(context);
                  _uploadImageToStorage(ImageSource.gallery);
                },
              ),
              TextButton(
                child: const Text("카메라"),
                onPressed: () {
                  Navigator.pop(context);
                  _uploadImageToStorage(ImageSource.camera);
                },
              )
            ],
          );
        });
  }
  Future<String> storeImage() async {
    _user = await _firebaseAuth.currentUser!;
    final response = await _firebaseStorage
        .ref()
        .child("profile/${_user.uid}")
        .getDownloadURL();
    print("@######################");
    return response;
  }

  bool needDelExist = false;
  Future<bool> checkExist() async {
    try {
      await FirebaseFirestore.instance.doc(_firebaseAuth.currentUser!.uid).get().then((doc)
      {
        needDelExist = doc.exists;
      });
      FirebaseFirestore.instance
          .collection("profile")
          .doc(_firebaseAuth.currentUser!.uid)
          .delete();
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@44");
      return needDelExist ;
    } catch(e) {
      return false ;
    }
  }

  Future addImage(final url) async {
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@33");
    final userInfo = FirebaseFirestore.instance
        .collection("profile")
        .doc(_firebaseAuth.currentUser!.uid) ;

    userInfo.set({
      'email': FirebaseAuth.instance.currentUser!.email,
      'imageURL': url,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@33");
  }

  Future<void> _uploadImageToStorage(ImageSource source) async {
    final _picker = ImagePicker();
    final image = await ImagePicker.platform.getImage(source: source);
    //ImagePicker.platform.getImage(source: source);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
      print(_image);
    });
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    final storageReference =
    _firebaseStorage.ref().child("profile/${_user.uid}");
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    final storageUploadTask = await storageReference.putFile(_image!);

    final response = await storeImage();
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(response);
    checkExist();
    await addImage(response);
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
      maxY: 70,
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
