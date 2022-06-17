import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

//クラスインポート
import 'package:qanvas/router/get_routes.dart';
import 'package:qanvas/services/user/pages/sign_in.dart';

List<Box> boxlist = [];

Future<List<Box>> _openBox() async{
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  //複数のHive Box
  var folderBox = await Hive.openBox("Folder");
  var noteBox = await Hive.openBox("Note");
  var imageBox = await Hive.openBox("Image");
  return boxlist;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _openBox();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget{
  const Myapp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: GetRoutes.pages,
      home: SignInPage(),
    );
  }

}