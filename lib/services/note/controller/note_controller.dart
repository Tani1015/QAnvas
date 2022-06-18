import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qanvas/services/note/controller/folder_controller.dart';

class NoteController extends GetxController {
  NoteController(this.keyName);
  final String? keyName;

  List? noteList = [];

  void onInit(){
    noteList = Hive.box("Note").get(keyName);
  }

  void addNote(Uint8List? imgName){
    noteList?.add(imgName!);
  }
}