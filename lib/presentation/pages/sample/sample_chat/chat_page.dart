
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// flutter_chat_uiを使うためのパッケージをインポート
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

// ランダムなIDを採番してくれるパッケージ
import 'package:uuid/uuid.dart';

// バブルチャット
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';



class ChatScreen extends StatefulWidget {
  const ChatScreen(this.name, {Key? key}) : super(key: key);

  final String name;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  String randomId = Uuid().v4();
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66', firstName: 'sample');


  void initState() {
    _getMessages();
    super.initState();
  }

  // firestoreからメッセージの内容をとってきて_messageにセット
  void _getMessages() async {
    final getData = await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.name)
        .collection('contents')
        .get();

    final message = getData.docs
        .map((d) => types.TextMessage(
        author:
        types.User(id: d.data()['uid'], firstName: d.data()['name']),
        createdAt: d.data()['createdAt'],
        id: d.data()['id'],
        text: d.data()['text']))
        .toList();

    setState(() {
      _messages = [...message];
    });
  }

  // メッセージ内容をfirestoreにセット
  void _addMessage(types.TextMessage message) async {
    setState(() {
      _messages.insert(0, message);
    });
    await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.name)
        .collection('contents')
        .add({
      'uid': message.author.id,
      'name': message.author.firstName,
      'createdAt': message.createdAt,
      'id': message.id,
      'text': message.text,
    });
  }


  // メッセージ送信時の処理
  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomId,
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    return Focus(
        focusNode: focusNode,
        child: GestureDetector(
          onTap: focusNode.requestFocus,
          child: Scaffold(

            body: Chat(
              theme: const DefaultChatTheme(
                // メッセージ入力欄の色
                inputBackgroundColor: Colors.grey,
                // 送信ボタン
                sendButtonIcon: Icon(Icons.send),
                sendingIcon: Icon(Icons.update_outlined),
              ),
              // ユーザーの名前を表示するかどうか
              showUserNames: true,

              // メッセージの配列
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
            ),
          ),
        )
    );
  }
}