import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:qanvas/presentation/pages/sample/sample_chat/room_add.dart';
import 'package:qanvas/presentation/pages/sample/sample_chat/room_info.dart';

class RoomListPage extends StatelessWidget {
  // 引数からユーザー情報を受け取れるようにする
  RoomListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(context.height * 0.08),
        child:  AppBar(
          title: SizedBox(
            width: context.width * 0.4,
            height: context.height * 0.07,
            child: Image.asset("assets/images/QAnvas_title.png"),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            // Stream 非同期処理の結果を元にWidgetを作る
              child: StreamBuilder<QuerySnapshot>(
                // 投稿メッセージ一覧の取得
                stream: FirebaseFirestore.instance
                    .collection('chat_room')
                    .orderBy('createdAt')
                    .snapshots(),
                builder: (context, snapshot) {
                  // データが取得できた場合
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView(
                      children: documents.map((document) {
                        return Card(
                          child: ListTile(
                            title: Text(document['name']),
                            trailing: IconButton(
                              icon: Icon(Icons.input),
                              onPressed: () async {
                                // チャットページへ画面遷移
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Roominfo(chatRoom: document['name']);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  // データが読込中の場合
                  return const Center(
                    child: Text('読込中……'),
                  );
                },
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return AddRoomPage();
          }));
        },
      ),
    );
  }
}