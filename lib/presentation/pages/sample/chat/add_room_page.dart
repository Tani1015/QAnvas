import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/gen/assets.gen.dart';
import 'package:qanvas/model/entities/sample/chat/chat.dart';
import 'package:qanvas/model/entities/sample/question/question.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:qanvas/model/use_cases/sample/chat_controller.dart';
import 'package:qanvas/presentation/widgets/rounded_button.dart';


final roomNameTextProvider = Provider.autoDispose((ref) {
  return TextEditingController(text: '');
});

class AddRoomPage extends HookConsumerWidget {
  const AddRoomPage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => const AddRoomPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomChats = ref.watch(roomChatProvider);
    final roomNameTextController = ref.watch(roomNameTextProvider);

    return Scaffold(
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
                controller: roomNameTextController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'ルーム名を入力',
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
                if(roomNameTextController.text != "") {
                  final List<Chat> emptyChatList= [];
                  final userId = ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
                  final List<String> userIdList = [];
                  userIdList.add(userId!);
                  final List<Question> emptyQuestionList = [];
                  final roomName = roomNameTextController.text;
                  ref.read(roomChatProvider.notifier).create(roomName,userIdList);
                  Navigator.of(context).pop();
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  'ルーム追加',
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
