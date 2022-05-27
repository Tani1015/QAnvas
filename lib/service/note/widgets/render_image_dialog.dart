


import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RenderImageDialog extends StatelessWidget{
  final Future<Uint8List?> imageFuture;

  const RenderImageDialog({Key? key, required this.imageFuture}) : super(key: key);

  Widget build(BuildContext context){

    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return AlertDialog(
      title: const Text("ノート画像"),
      content: FutureBuilder<Uint8List?>(
        future: imageFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return  SizedBox(
              height: height * 0.1,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          if(!snapshot.hasData || snapshot.data == null){
            return const SizedBox();
          }
          return InteractiveViewer(
            maxScale: 10,
            child: Image.memory(snapshot.data!),
          );
        }
      ),
    );
  }
}