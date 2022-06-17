import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';


class FolderController extends GetxController {

  List? folderList = [];

 @override
  void onInit(){
   folderList = Hive.box("Folder").get("Folder");
   super.onInit();
 }

 void addFolder(String folderName){
   folderList?.add(folderName);
 }

 void removeFolder(String folderName){
   folderList?.remove(folderName);
 }
}