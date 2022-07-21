import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/gen/assets.gen.dart';
import 'package:qanvas/model/entities/sample/chat/chat.dart';
import 'package:qanvas/model/entities/sample/question/question.dart';
import 'package:qanvas/model/entities/sample/room_chat/room_chat.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:qanvas/model/use_cases/sample/chat_controller.dart';
import 'package:qanvas/model/use_cases/sample/search_user_controller.dart';
import 'package:qanvas/presentation/custom_hooks/use_effect_once.dart';
import 'package:qanvas/presentation/widgets/rounded_button.dart';


class AddUserPage extends HookConsumerWidget {
  const AddUserPage(this.data, {Key? key}) : super(key: key);

  static Future<void> show(BuildContext context, RoomChat data) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => AddUserPage(data),
      ),
    );
  }
  final RoomChat? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchUserTextController = ref.watch(searchUserTextEditingController);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,

        title: SizedBox(
          height: context.height * 0.1,
          width: context.width * 0.3,
          child: Assets.images.qAnvasTitle.image(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: context.width * 0.95,
              height:  context.height * 0.07,
              color: Colors.white,
              margin: EdgeInsets.all(context.width * 0.05),
              child: TextFormField(
                autofocus: false,
                controller: searchUserTextController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'ユーザー名を入力',
                  hintStyle: const TextStyle(fontSize: 17, color: Colors.black26),
                  fillColor: Colors.grey[400],
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Colors.red
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RoundedButton(
              color: Colors.red,
              onTap: () {
                if(searchUserTextController.text != "") {
                  final users = ref.watch(searchUserProvider);
                  ref.read(searchUserProvider.notifier).search(searchUserTextController.text);
                  final userId = users[0].userId;
                  var userIdList = data?.userId;
                  userIdList = [...?userIdList, userId];
                  ref.read(roomChatProvider.notifier).updateUser(data!, userIdList);
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  'ユーザを追加',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
