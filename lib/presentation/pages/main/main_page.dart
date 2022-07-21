import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qanvas/extensions/context_extension.dart';
import 'package:qanvas/model/entities/sample/room_chat/room_chat.dart';
import 'package:qanvas/presentation/pages/sample/chat/room_chat_page.dart';
import 'package:qanvas/presentation/pages/sample/note/note_page.dart';
// import 'package:qanvas/presentation/pages/sample/note/note_page.dart';
import 'package:qanvas/presentation/pages/sample/sample_chat/roomList_page.dart';
import 'package:qanvas/presentation/pages/sample/search/search_page.dart';
import 'package:qanvas/presentation/pages/sample/user/user_page.dart';

import 'tab_navigator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  static Future<void> show(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushReplacement<void, void>(
        PageTransition(
          child: const MainPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds:  1000),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = useState<List<Widget>>([
      const SearchScreen(),
      const RoomChatPage(),
      const NotePage(),
      const UserPage(),
    ]);

    final navigatorKeys = useState([
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
    ]);

    //bottomNavi index
    final selectedIndex = useState(0);

    //画面遷移するために処理を行う
    return WillPopScope(
      onWillPop: () async {
        final keyTab = navigatorKeys.value[selectedIndex.value];
        if(keyTab.currentState != null && keyTab.currentState!.canPop()) {
          return !await keyTab.currentState!.maybePop();
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: List.generate(
            widgets.value.length,
                (index) => Offstage(
              offstage: index != selectedIndex.value,
              child:  TabNavigator(
                navigatorKey: navigatorKeys.value[index],
                page: widgets.value[index],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ホーム',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: 'チャット',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: 'ノート',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'ユーザ',
              tooltip: '',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex.value,
          showSelectedLabels: !context.isPhoneSize,
          showUnselectedLabels: !context.isPhoneSize,
          onTap: (index) {
            selectedIndex.value = index;
          },
          selectedFontSize: 12,
        ),
      ),
    );
  }
}