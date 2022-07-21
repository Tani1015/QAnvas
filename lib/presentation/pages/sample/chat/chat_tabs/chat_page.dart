import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:qanvas/model/entities/sample/chat/chat.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:qanvas/model/use_cases/sample/chat_controller.dart';
import 'package:qanvas/model/use_cases/sample/my_profile.dart';
import 'package:qanvas/presentation/custom_hooks/use_effect_once.dart';
import 'package:qanvas/presentation/pages/sample/chat/chat_tabs/add_user_page.dart';
import 'package:qanvas/presentation/pages/sample/chat/chat_tabs/question_page.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage(this.index, {Key? key}) : super(key: key);

  final int index;

  static Future<void> show(BuildContext context, int index) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => ChatPage(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final chatRooms = ref.watch(roomChatProvider);
    final newChatList = useState<List<Chat>>([]);
    final userId = ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
    final profile = ref.watch(fetchMyProfileProvider);


    final _user = types.User(id: userId!, firstName:  profile.value!.name);
    final message =  useState<List<types.TextMessage>?>([]);
    final List<types.TextMessage> emptyList = [];

    useEffectOnce(() {
      Future(() async {
        final result = await ref.read(roomChatProvider.notifier).fetch();
        if(chatRooms[index].chatList != null){
          newChatList.value = chatRooms[index].chatList!;
          message.value = chatRooms[index].chatList?.map((d) =>
              types.TextMessage(
                  author: _user,
                  id: chatRooms[index].roomId!,
                  text: d.chat!,
                  createdAt: chatRooms[index].createdAt?.millisecondsSinceEpoch
              )).toList();
        }
        result.when(
          success: () {},
          failure: (_) {},
        );
      });
      return null;
    });

    return Focus(
      focusNode:  useFocusNode(),
      child: GestureDetector(
        onTap: useFocusNode().requestFocus,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  AddUserPage.show(context, chatRooms[index]);
                },
                icon: const Icon(Icons.add),
                splashColor: Colors.white,
                highlightColor: Colors.white,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context,rootNavigator: true).push<void>(
                      MaterialPageRoute(
                        builder: (_) => const QuestionPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward)
              ),
            ],
            backgroundColor: Colors.white,
            title: Text(chatRooms[index].roomName!,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body:  ValueListenableBuilder(
            valueListenable: newChatList,
            builder: (context,List<Chat>? value, _) {
              var messsages = value?.map((e) =>
                  types.TextMessage(
                      author: _user,
                      id: chatRooms[index].roomId!,
                      text: e.chat!,
                      createdAt: chatRooms[index].createdAt?.millisecondsSinceEpoch
                  )).toList();
              return value != null
                  ? chat.Chat(
                theme: const chat.DefaultChatTheme(
                  // メッセージ入力欄の色
                  inputBackgroundColor: Colors.blue,
                  // 送信ボタン
                  sendButtonIcon: Icon(Icons.send),
                  sendingIcon: Icon(Icons.update_outlined),
                ),
                showUserNames: true,
                user: _user,
                messages: messsages!,
                onSendPressed: (types.PartialText message) {
                  Chat newChat = Chat(
                      chatId: chatRooms[index].roomId,
                      userId: userId,
                      chat: message.text,
                      name: profile.value?.name,
                      createdAt: DateTime.now()
                  );
                  newChatList.value = [newChat, ...newChatList.value];
                  ref.read(roomChatProvider.notifier)
                      .updateChat(chatRooms[index], newChatList.value);
                },
              )
                  : chat.Chat(
                theme: const chat.DefaultChatTheme(
                  // メッセージ入力欄の色
                  inputBackgroundColor: Colors.blue,
                  // 送信ボタン
                  sendButtonIcon: Icon(Icons.send),
                  sendingIcon: Icon(Icons.update_outlined),
                ),
                showUserNames: true,
                user: _user,
                messages: emptyList,
                onSendPressed: (types.PartialText message) {
                  Chat newChat = Chat(
                      chatId: chatRooms[index].roomId,
                      userId: userId,
                      chat: message.text,
                      name: profile.value?.name,
                      createdAt: DateTime.now()
                  );
                  newChatList.value = [newChat, ...newChatList.value];
                  print(newChatList);
                  ref.read(roomChatProvider.notifier)
                      .updateChat(chatRooms[index], newChatList.value);
                },
              );
            },
          )
        ),
      ),
    );
  }

}