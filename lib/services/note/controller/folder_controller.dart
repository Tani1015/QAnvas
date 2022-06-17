import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';


class FolderController extends GetxController {

  List? folderList = [];
  List? emptyList = [];

 @override
  void onInit(){
   if(Hive.box("Folder").get("Folder") != null){
     folderList = Hive.box("Folder").get("Folder");
   }else {
     Hive.box("Folder").put("Folder", emptyList);
   }
   super.onInit();
 }

 void addFolder(String folderName){
   folderList?.add(folderName);
 }

 void removeFolder(String folderName){
   folderList?.remove(folderName);
 }
}