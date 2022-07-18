import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class AddRoomPage extends StatefulWidget {
  AddRoomPage();

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddRoomPage> {
  String roomName = '';

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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'チャットルーム名'),
                keyboardType: TextInputType.multiline,
                onChanged: (String value) {
                  setState(() {
                    roomName = value;
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('投稿'),
                  onPressed: () async {
                    final date = DateTime.now().toLocal().toIso8601String();

                    await FirebaseFirestore.instance
                        .collection('chat_room')
                        .doc(roomName)
                        .set({
                      'name': roomName,
                      'createdAt': date,
                    });
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}