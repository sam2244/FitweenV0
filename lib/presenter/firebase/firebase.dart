import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// 파이어베이스 프리젠터
class FirebasePresenter {
  static var a = FirebaseAuth.instance;
  static var f = FirebaseFirestore.instance;
  static var s = FirebaseStorage.instance;
}