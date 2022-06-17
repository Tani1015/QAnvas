import 'package:hive_flutter/hive_flutter.dart';
import 'dart:typed_data';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class RenderImageDialog extends StatelessWidget{
  final Future<Uint8List?> imageFuture;
  final int? index;

  const RenderImageDialog({Key? key, required this.imageFuture, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context){
    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final TextEditingController noteNameController = TextEditingController();
    final String noteName = Hive.box('Folder').getAt(0)[index];

    return AlertDialog(
      content: FutureBuilder<Uint8List?>(
        future: imageFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return  SizedBox(
              height: height * 0.1,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          if(!snapshot.hasData || snapshot.data == null){
            return const SizedBox();
          }
          return InteractiveViewer(
            maxScale: 10,
            child: Container(
              child: Image.memory(snapshot.data!),
              color: Colors.grey.shade200,
            )
          );
        }
      ),
      actions: [
        Column(
          children: <Widget>[
            TextField(
              controller: noteNameController,
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration.collapsed(
                hintText: '名前を入力してください',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('キャンセル',
                    style: TextStyle(
                        color: Colors.blue
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                  ),
                ),
                TextButton(
                  style:ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                  ),
                  child: const Text('追加',
                    style: TextStyle(color:  Colors.blue),
                  ),
                  onPressed: () {
                    //画像エンコード
                    String? noteNameText = noteNameController.text.trim();
                    imageFuture.then((value) {
                      Map<String, dynamic> noteMap = {
                        noteNameText: value
                      };
                      Hive.box('Note').put(noteName, noteMap);
                    });
                    Get.offNamedUntil('/Note', (route) => false,arguments: index);
                  },
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}