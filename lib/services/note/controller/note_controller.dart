import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteController extends GetxController {
  NoteController(this.keyname);
  final String? keyname;
  var noteList;

  @override
  void onInit() {
    noteList = Hive.box("Note").get("$keyname");
    super.onInit();
  }

  // void removeNote(String noteName){
  //   noteList?.remove(noteName);
  // }
}