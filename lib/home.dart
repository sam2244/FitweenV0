import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitween'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: const Color(0xFF38597E),
          iconSize: 25.0,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('plans').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                ),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  child: Column(
                    children: [
                      IconButton(
                        icon: new Icon(Icons.arrow_back_ios_new_rounded),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushNamed(context, '/addplan',);
                          },
                      ),
                    ],
                  ),
                );
              }
              ).toList(),
            );
          }
      ),
    );
  }
}
