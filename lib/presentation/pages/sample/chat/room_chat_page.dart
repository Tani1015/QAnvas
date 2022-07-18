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
        : ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final data = chatRooms[index];
            return Padding(
              padding: const EdgeInsets.only(left: 8).copyWith(top: 10),
              child: ListTile(
                title: Text(data.roomName!),
                subtitle: Text(
                  data.chatList!.isEmpty
                      ? "チャットしよう"
                      : data.chatList![0].chat!
                ),
                onTap: () {
                  ChatPage.show(context, index);
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 1);
          },
          itemCount: chatRooms.length
        ),
    );
  }

}
