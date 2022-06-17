import 'package:get/get.dart';

//クラスインポート
import 'package:qanvas/services/user/controller/user_controller.dart';
import 'package:qanvas/services/search/controller/search_controller.dart';
import 'package:qanvas/services/note/controller/folder_controller.dart';
import 'package:qanvas/router/route_controller.dart';
import 'package:qanvas/services/notification/controller/notification_controller.dart';
import 'package:qanvas/services/chat/controller/chat_controller.dart';

class BottomRoutes_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RouteController>(() => RouteController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<FolderController>(() => FolderController());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}