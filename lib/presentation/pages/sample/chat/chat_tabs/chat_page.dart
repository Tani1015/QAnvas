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
    final List<Chat> emptyList = [];
    final newChatList = useState<List<Chat>>(emptyList);
    final userId = ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
    final profile = ref.watch(fetchMyProfileProvider);


    final _user = types.User(id: userId!, firstName:  profile.value!.name);
    List<types.TextMessage>? textMessage = [];

    useEffectOnce(() {
      Future(() async {
        final result = await ref.read(roomChatProvider.notifier).fetch();
        if(chatRooms[index].chatList != null){
          newChatList.value = chatRooms[index].chatList!;
          textMessage = chatRooms[index].chatList?.map((d) =>
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
          body:  chat.Chat(
            theme: const chat.DefaultChatTheme(
              // メッセージ入力欄の色
              inputBackgroundColor: Colors.blue,
              // 送信ボタン
              sendButtonIcon: Icon(Icons.send),
              sendingIcon: Icon(Icons.update_outlined),
            ),
            showUserNames: true,
            user: _user,
            messages: textMessage!,
            onSendPressed: (types.PartialText message) {
              Chat newChat = Chat(
                  chatId: chatRooms[index].roomId,
                  userId: userId,
                  chat: message.text,
                  name: profile.value?.name,
                  createdAt: DateTime.now()
              );
              newChatList.value.add(newChat);
              ref.read(roomChatProvider.notifier)
                  .updateChat(chatRooms[index], newChatList.value);
            },
          ),
        ),
      ),
    );
  }

}