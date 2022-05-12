import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spring_button/spring_button.dart';
import 'package:flutter_painter/flutter_painter.dart';

final questionstateprovider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: "");
});

class QuestionAddScreen extends StatefulHookConsumerWidget {
  const QuestionAddScreen({Key? key}) : super(key: key);

  @override
  QuestionAddState createState() => QuestionAddState();
}

class QuestionAddState extends ConsumerState<QuestionAddScreen> {
  //ぺインター設定
  FocusNode textFocusNode = FocusNode();
  Paint shapePaint = Paint()
    ..strokeWidth = 2
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  late PainterController controller;

  @override
  void initState() {
    super.initState();
    controller = PainterController(
        settings: PainterSettings(

            //テキスト設定
            text: TextSettings(
                focusNode: textFocusNode,
                textStyle: const TextStyle(color: Colors.black, fontSize: 16)),

            //freestyle 設定
            freeStyle:
                const FreeStyleSettings(color: Colors.red, strokeWidth: 2),

            //ペイント設定
            shape: ShapeSettings(paint: shapePaint),

            //scale 設定
            scale: const ScaleSettings(
              enabled: true,
              minScale: 1,
              maxScale: 5,
            )));

    textFocusNode.addListener(onFocus);
  }

  void onFocus() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textheight = MediaQuery.of(context).viewInsets.bottom;

    //プロバイダー
    final questionController = ref.watch(questionstateprovider);

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: SizedBox(
            width: weight * 0.4,
            height: height * 0.07,
            child: Image.asset("assets/images/QAnvas_title.png"),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          actions: [
            SizedBox(
              width: weight * 0.25,
              child: SpringButton(
                SpringButtonType.WithOpacity,
                Padding(
                  padding: const EdgeInsets.all(12.5),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: const Center(
                      child: Text(
                        '投稿する',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {

                  //ボトムシート
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25))),
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: height * 0.7,
                          child: Column(
                            children: const <Widget>[],
                          ),
                        );
                      });

                },
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            ValueListenableBuilder<PainterControllerValue>(
                valueListenable: controller,
                builder: (context,_,child){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height:  height * 0.1,
                        width: weight * 0.2,
                        child: IconButton(
                          onPressed: () {
                            controller.selectedObjectDrawable == null
                                ? null
                                : print("delete");
                          },
                          icon: const Icon(Icons.delete),
                        )
                      ),
                      SizedBox(
                          height:  height * 0.1,
                          width: weight * 0.2,
                          child: IconButton(
                            tooltip: "画像反転",
                            onPressed: () {
                              controller.selectedObjectDrawable != null
                                  && controller.selectedObjectDrawable is ImageDrawable
                                  ? print("flip")
                                  : null ;
                            },
                            icon: const Icon(Icons.flip),
                          )
                      ),
                      SizedBox(
                          height:  height * 0.1,
                          width: weight * 0.2,
                          child: IconButton(
                            onPressed: () {
                              controller.selectedObjectDrawable == null
                                  ? null
                                  : print("undo");
                            },
                            icon: const Icon(Icons.undo),
                          )
                      ),
                      SizedBox(
                          height:  height * 0.1,
                          width: weight * 0.2,
                          child: IconButton(
                            onPressed: () {
                              controller.selectedObjectDrawable == null
                                  ? null
                                  : print("redo");
                            },
                            icon: const Icon(Icons.redo),
                          )
                      )
                    ]
                  );
                }
            ),
            Column(
              children: <Widget>[
                Center(
                    child: InteractiveViewer(
                      clipBehavior: Clip.none,
                      maxScale: 4.0,

                      //拡大、縮小の移動判定
                      panEnabled: true,

                      child: Container(
                        margin: EdgeInsets.all(weight * 0.01),
                        width: weight * 0.93,
                        height: height * 0.65 - textheight * 0.75,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(6),),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.white.withOpacity(0)),
                              margin: EdgeInsets.all(weight * 0.05),
                              child: AutoSizeTextField(
                                //テキスト入力判定
                                enabled: true,
                                //テキストスタイル
                                style: const TextStyle(fontSize: 18),
                                //文字の色変更はsubstringで文字数を取得して変える
                                //文字の大きさや色を変えるときはその前のところまでは一回保存して再度テキストフィールドを読んで、つなげる

                                maxLines: null,
                                autofocus: true,
                                controller: questionController,
                              ),
                            ),
                          ],
                        ),
                  ),
                ))
              ],
            ),
          ],
        )
    );
  }
}
