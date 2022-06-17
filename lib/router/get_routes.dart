import 'package:get/get.dart';
import 'package:qanvas/router/bottom_routes_binding.dart';
import 'package:qanvas/services/note/screens/make_note_screen.dart';
import 'package:qanvas/services/note/screens/note_screen.dart';
import 'package:qanvas/services/search/screens/add_question_note_screen.dart';
import 'package:qanvas/services/search/screens/add_question_screen.dart';

//クラスインポート
import 'bottom_routes.dart';
import 'package:qanvas/services/user/pages/sign_in.dart';
import 'package:qanvas/services/user/pages/sign_up.dart';
import 'package:qanvas/services/search/screens/search_screen.dart';
import 'package:qanvas/services/chat/screens/chat_screen.dart';
import 'package:qanvas/services/notification/screens/notification_screen.dart';
import 'package:qanvas/services/note/screens/folder_screen.dart';

class GetRoutes {
  static final pages = [
    GetPage(name: '/SignIn', page: () => SignInPage()),
    GetPage(name: '/SignUp', page: () => SignUpPage()),
    GetPage(name: '/Routes', page: () => BottomRoutes() ,binding: BottomRoutes_Binding()),
    GetPage(name: '/Search', page: () => const SearchScreen()),
    GetPage(name: '/Chat', page: () =>const ChatScreen()),
    GetPage(name: '/Notification', page: () => const NotificationScreen()),
    GetPage(name: '/Folder', page: () => const FolderScreen()),
    GetPage(name: '/AddQuestion', page: () => const AddQuestionScreen()),
    GetPage(name: '/AddQuestionNote', page: () => const AddQuestionNoteScreen()),
    GetPage(name: '/Note', page: () => const NoteScreen(), arguments:  {}),
    GetPage(name: '/MakeNote', page: () => const MakeNoteScreen(), arguments:  {})
  ];
}