//add item page

import 'dart:typed_data';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/gen/assets.gen.dart';
import 'package:qanvas/model/use_cases/sample/item_controller.dart';
import 'package:qanvas/presentation/custom_hooks/use_effect_once.dart';
import 'package:qanvas/presentation/pages/sample/search/add_question_note.dart';
import 'package:qanvas/presentation/widgets/rounded_button.dart';

final titleTextProvider = Provider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final categoryTextProvider = Provider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final addressTextProvider = Provider.autoDispose((ref) {
  return TextEditingController(text: '');
});

class MakeQuestionPage extends HookConsumerWidget {
  const MakeQuestionPage({super.key});


  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => const MakeQuestionPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleTextController = ref.watch(titleTextProvider);
    final questionTextController = ref.watch(addressTextProvider);
    final categoryTextController = ref.watch(categoryTextProvider);
    final local = Hive.box("Local");
    final image = local.get("Local");
    final itemNotifier = ref.read(itemProvider.notifier);
    // final List<int> empty = [];

    // useEffectOnce(() {
    //   if(image == null){
    //     local.put("Local", empty);
    //   }
    //   return null;
    // });
    useEffectOnce((){
      image;
      return null;
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          // leading: Builder(
          //   builder: (BuildContext context) {
          //     return IconButton(
          //       icon: const Icon(Icons.arrow_back),
          //       onPressed: () {
          //         local.delete('Local');
          //         Navigator.of(context).pop();
          //       },
          //     );
          //   },
          // ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: context.height * 0.03,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text('タイトル'),
                  ),
                  TextFormField(
                    controller: titleTextController,
                    decoration: const InputDecoration(
                      hintText: 'タイトルを入力してください',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(),
                      isDense: true,
                      counterText: '',
                    ),
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'タイトルを入力してください'
                        : null,
                    maxLength: 32,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text('質問'),
                  ),
                  TextFormField(
                    maxLines: 4,
                    controller: questionTextController,
                    decoration: const InputDecoration(
                      hintText: '質問を入力してください',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(),
                      isDense: true,
                      counterText: '',
                    ),
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? '質問を入力してください'
                        : null,
                    maxLength: 32,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text('カテゴリー'),
                  ),
                  TextFormField(
                    controller: categoryTextController,
                    decoration: const InputDecoration(
                      hintText: 'カテゴリーを入力してください',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(),
                      isDense: true,
                      counterText: '',
                    ),
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'カテゴリーを入力してください'
                        : null,
                    maxLength: 32,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RoundedButton(
                    color: Colors.red,
                    elevation: 2,
                    onTap: () async {
                      try {
                        Navigator.of(context,rootNavigator: true).push<void>(
                          MaterialPageRoute(
                            builder: (_) => const AddQuestionNotePage(),
                          ),
                        );
                        local.delete("Local");
                      } on Exception catch (e) {
                        await showOkAlertDialog(context: context, title: '保存できませんでした');
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        'グラフを作成',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RoundedButton(
                    color: Colors.blue,
                    elevation: 2,
                    onTap: () async {
                      try {
                        final title = titleTextController.text;
                        final category = categoryTextController.text;
                        final question = questionTextController.text;
                        await itemNotifier.createWithNoteImage(title,question, category);
                        local.delete("Local");
                        Navigator.pop(context);
                      } on Exception catch (e) {
                        await showOkAlertDialog(context: context, title: '保存できませんでした');
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        '投稿する',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}