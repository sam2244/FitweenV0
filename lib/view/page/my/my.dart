import 'package:fitween1/presenter/page/my.dart';
import 'package:fitween1/view/page/my/widget.dart';
import 'package:fitween1/view/widget/text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 마이 페이지
class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPresenter>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: const MyAppBar(),
          body: Column(
            children: [
              const MyProfileImageButton(),
              const MyWeightGraphView(title: '체중', ratio: 1.5),
              Container(
                margin: const EdgeInsets.all(20.0),
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
    );
  }
  // Future<String> storeImage() async {
  //   _user = await _firebaseAuth.currentUser!;
  //   final response = await _firebaseStorage
  //       .ref()
  //       .child("profile/${_user.uid}")
  //       .getDownloadURL();
  //   print("@######################");
  //   return response;
  // }
  //
  // bool needDelExist = false;
  // Future<bool> checkExist() async {
  //   try {
  //     await FirebaseFirestore.instance.doc(_firebaseAuth.currentUser!.uid).get().then((doc)
  //     {
  //       needDelExist = doc.exists;
  //     });
  //     FirebaseFirestore.instance
  //         .collection("profile")
  //         .doc(_firebaseAuth.currentUser!.uid)
  //         .delete();
  //     print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@44");
  //     return needDelExist ;
  //   } catch(e) {
  //     return false ;
  //   }
  // }
  //
  // Future addImage(final url) async {
  //   print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@33");
  //   final userInfo = FirebaseFirestore.instance
  //       .collection("profile")
  //       .doc(_firebaseAuth.currentUser!.uid) ;
  //
  //   userInfo.set({
  //     'email': FirebaseAuth.instance.currentUser!.email,
  //     'imageURL': url,
  //     'name': FirebaseAuth.instance.currentUser!.displayName,
  //     'userId': FirebaseAuth.instance.currentUser!.uid,
  //   });
  //   print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@33");
  // }
  //
  // Future<void> _uploadImageToStorage(ImageSource source) async {
  //   final _picker = ImagePicker();
  //   final image = await ImagePicker.platform.getImage(source: source);
  //   //ImagePicker.platform.getImage(source: source);
  //   if (image == null) return;
  //   setState(() {
  //     _image = File(image.path);
  //     print(_image);
  //   });
  //   print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
  //   final storageReference =
  //   _firebaseStorage.ref().child("profile/${_user.uid}");
  //   print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
  //   final storageUploadTask = await storageReference.putFile(_image!);
  //
  //   final response = await storeImage();
  //   print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
  //   print(response);
  //   checkExist();
  //   await addImage(response);
  // }
  //
  // Widget bottomTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Colors.black,
  //     fontSize: 15,
  //   );
  //   Widget text;
  //   switch (value.toInt()) {
  //     case 2:
  //       text = const Text('MAR', style: style);
  //       break;
  //     case 5:
  //       text = const Text('JUN', style: style);
  //       break;
  //     case 8:
  //       text = const Text('SEP', style: style);
  //       break;
  //     default:
  //       text = const Text('', style: style);
  //       break;
  //   }
  //
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     space: 8.0,
  //     child: text,
  //   );
  // }
  //
  // Widget leftTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Color(0xff67727d),
  //     fontWeight: FontWeight.bold,
  //     fontSize: 15,
  //   );
  //   String text;
  //   switch (value.toInt()) {
  //     case 1:
  //       text = '30';
  //       break;
  //     case 3:
  //       text = '50';
  //       break;
  //     case 5:
  //       text = '70';
  //       break;
  //     default:
  //       return Container();
  //   }
  //
  //   return Text(text, style: style, textAlign: TextAlign.left);
  // }
  //
}
