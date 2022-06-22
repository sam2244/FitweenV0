import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPlanPage extends StatefulWidget {
  const AddPlanPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AddPlanPage> createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  TextEditingController splace = TextEditingController();
  TextEditingController fplace = TextEditingController();
  String pnselectedValue = '2';
  String scselectedValue1 = '14';
  String smselectedValue1 = '30';
  bool car = true;
  bool taxi = false;
  String transport = 'car';

  @override
  Widget build(BuildContext context) {
    final Size displaysize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('방만들기', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF38597E),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 25.0,
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          TextButton(
              child: const Text(
                  "완료", style: TextStyle(fontSize: 18, color: Colors.white)),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await addPlan(
                    transport,
                    splace.text,
                    fplace.text,
                    pnselectedValue,
                    scselectedValue1,
                    smselectedValue1,
                  );
                  Navigator.pushNamed(context, '/home',);
                }
              }),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: const Text('탑승 차량', style: TextStyle(fontSize: 15.0)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20.0),
                      width: 170,
                      height: 40,
                      decoration: BoxDecoration(
                          color: car ? const Color(0xFF98C9FF) : const Color(
                              0xFFF0EEEE),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      child: TextButton(
                          child: const Text(
                              "카풀", style: TextStyle(fontSize: 15, color: Colors
                              .black)),
                          onPressed: () {
                            setState(() {
                              car = true;
                              taxi = false;
                              transport = 'car';
                            });
                          }),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20.0),
                      width: 170,
                      height: 40,
                      decoration: BoxDecoration(
                          color: taxi ? const Color(0xFF98C9FF) : const Color(
                              0xFFF0EEEE),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      child: TextButton(
                          child: const Text(
                              "택시", style: TextStyle(fontSize: 15, color: Colors
                              .black)),
                          onPressed: () {
                            setState(() {
                              car = false;
                              taxi = true;
                              transport = 'taxi';
                            });
                          }),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                  child: const Text('출발지', style: TextStyle(fontSize: 15.0)),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 5.0, left: 20.0, right: 20.0),
                  child: TextFormField(
                    controller: splace,
                    decoration: const InputDecoration(
                      hintText: '출발 장소를 입력해주세요.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '출발 장소를 다시 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                  child: const Text('도착지', style: TextStyle(fontSize: 15.0)),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 5.0, left: 20.0, right: 20.0),
                  child: TextFormField(
                    controller: fplace,
                    decoration: const InputDecoration(
                      hintText: '도착 장소를 입력해주세요.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '도착 장소를 다시 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      child: const Text(
                          '탑승 가능 인원', style: TextStyle(fontSize: 15.0)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF0EEEE),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: DropdownButton<String>(
                        iconSize: 30.0,
                        value: pnselectedValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            pnselectedValue = newValue!;
                          });
                        },
                        items: <String>['1', '2', '3', '4', '5']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                        child: const Text('명')
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      child: const Text(
                          '출발 시간', style: TextStyle(fontSize: 15.0)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF0EEEE),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: DropdownButton<String>(
                        iconSize: 30.0,
                        value: scselectedValue1,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            scselectedValue1 = newValue!;
                          });
                        },
                        items: <String>[
                          '07',
                          '08',
                          '09',
                          '10',
                          '11',
                          '12',
                          '13',
                          '14',
                          '15',
                          '16',
                          '17',
                          '18',
                          '19',
                          '20',
                          '21',
                          '22',
                          '23'
                        ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                        child: const Text('시')
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF0EEEE),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: DropdownButton<String>(
                        iconSize: 30.0,
                        value: smselectedValue1,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            smselectedValue1 = newValue!;
                          });
                        },
                        items: <String>[
                          '00',
                          '05',
                          '10',
                          '15',
                          '20',
                          '25',
                          '30',
                          '35',
                          '40',
                          '45',
                          '50',
                          '55'
                        ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                        child: const Text('분')
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future addPlan(String transport, String splace, String fplace, String pnselectedValue, String scselectedValue1, String smselectedValue1) async {
    await FirebaseFirestore.instance.collection("rooms").add({
      "transport": transport,
      "start place": splace,
      'finish place': fplace,
      "max people" : pnselectedValue,
      "hour": scselectedValue1,
      "minute": smselectedValue1,
      'timestamp': DateFormat('yyyy-MM-dd HH:mm:ss.sss').format(DateTime.now()),
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'email': FirebaseAuth.instance.currentUser!.email,
    });
  }
}