import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//クラスインポート
import 'package:qanvas/service/search/screens/search_screen.dart';
import 'package:qanvas/service/chat/screens/chat_screen.dart';
import 'package:qanvas/service/notification/screens/notification_screen.dart';
import 'package:qanvas/service/note/screens/folder_screen.dart';

final screenTypeProvider = StateProvider<ScreenType>((ref) => ScreenType.Search);

enum ScreenType {
  Search,
  Chat,
  Notification,
  Note
}

class BottomRoute extends HookConsumerWidget{
  const BottomRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){

    final tabType = ref.watch(screenTypeProvider.state);

    //ページリスト
    final _ScreenList = [
      const SearchScreen(),
      const ChatScreen(),
      const NotificationScreen(),
      const FolderScreen(),
    ];

    final tabItems= [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.search_sharp,
            color: Colors.black,
          ),
          label: '検索',
          activeIcon: Icon(
            Icons.search_rounded,
            color: Colors.black,
          )
      ),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_outlined,
            color: Colors.black,
          ),
        label: 'チャット',
          activeIcon: Icon(
            Icons.chat,
            color: Colors.black,
          )
      ),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications_outlined,
            color: Colors.black,
          ),
          label: 'アクティブ',
          activeIcon: Icon(
            Icons.notifications,
            color: Colors.black,
          )
      ),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.note_add_outlined,
            color: Colors.black,
          ),
          label: 'ノート',
          activeIcon: Icon(
            Icons.note_add,
            color: Colors.black,
          )
      ),
    ];

    return Scaffold(
      body: _ScreenList[tabType.state.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabType.state.index,
        onTap: (index) {
          tabType.state = ScreenType.values[index];
        },
        items: tabItems,
        selectedItemColor: Colors.black,
        elevation: 0,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
      )
    );
  }
}
