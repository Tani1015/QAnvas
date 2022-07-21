import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/gen/assets.gen.dart';
import 'package:qanvas/model/use_cases/sample/chat_controller.dart';
import 'package:qanvas/presentation/custom_hooks/use_effect_once.dart';
import 'package:qanvas/presentation/pages/sample/chat/add_room_page.dart';
import 'package:qanvas/presentation/pages/sample/chat/chat_tabs/chat_page.dart';

class RoomChatPage extends HookConsumerWidget {
  const RoomChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final chatRooms = ref.watch(roomChatProvider);

    useEffectOnce(() {
      Future(() async {
        final result = await ref.read(roomChatProvider.notifier).fetch();
        result.when(
          success: () {},
          failure: (_) {},
        );
      });
      return null;
    });

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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            highlightColor: Colors.white,
            splashColor: Colors.white,
            color: Colors.black,
            onPressed: () {
              AddRoomPage.show(context);
            },
          ),
        ],
      ),
      body: chatRooms.isEmpty
        ? const Center(
            child: Text("ルームを追加してください!"),
          )
        : ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final data = chatRooms[index];
            return Padding(
              padding: const EdgeInsets.only(left: 30).copyWith(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20))
                      .copyWith(bottomLeft: const Radius.circular(20))
                ),
                child: ListTile(
                  trailing: const Icon(Icons.arrow_forward_outlined),
                  iconColor: Colors.red.shade300,
                  title: Text(data.roomName!),
                  subtitle: data.chatList != null
                    ? Text(data.chatList![0].chat!)
                    : const Text("チャットしよう!"),
                  onTap: () {
                    ChatPage.show(context, index);
                  },
                ),
              )
            );
          },
          itemCount: chatRooms.length
        ),
    );
  }

}
