import 'package:flutter/material.dart';
import 'package:get/get.dart';

//クラスインポート
import 'route_controller.dart';
import 'package:qanvas/services/search/screens/search_screen.dart';
import 'package:qanvas/services/chat/screens/chat_screen.dart';
import 'package:qanvas/services/notification/screens/notification_screen.dart';
import 'package:qanvas/services/note/screens/folder_screen.dart';

class BottomRoutes extends StatelessWidget{

  var bottomNavigationItem = [
    const BottomNavigationBarItem(icon: Icon(Icons.update), label: ""),
    const BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: ""),
    const BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "")
  ];

  BottomRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RouteController>(
        builder: (controller) {

          return Scaffold(
              body: IndexedStack(
                index: controller.tappedIndex,
                children: const [
                  SearchScreen(),
                  ChatScreen(),
                  NotificationScreen(),
                  FolderScreen(),
                ],
              ),
              extendBody: true,
              bottomNavigationBar: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0.1,
                currentIndex: controller.tappedIndex,
                onTap: controller.changeTabIndex,
                items: bottomNavigationItem,
                selectedItemColor: Colors.red,
                unselectedItemColor: Colors.black,
                backgroundColor: Colors.black26,
              )
          );
        }
    );
  }
}
