import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//クラスインポート
import 'package:qanvas/service/note/screens/folder_screen.dart';
import 'package:qanvas/service/note/state/folder_state.dart';
import 'package:qanvas/service/note/state/note_state.dart';



class NoteScreen extends HookConsumerWidget{
  const NoteScreen({Key? key, required this.index}) : super(key: key);

  final String? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FolderList = ref.read(folderProvider.notifier);
    final int folderIndex = int.parse(index!);
    final noteKey = FolderList.state[folderIndex];

    final NoteProvider = StateNotifierProvider<NoteState,List<String>>(
            (ref) => NoteState(noteKey)
    );

    final noteNotifier = ref.read(NoteProvider.notifier);
    final NoteController = ref.watch(NoteProvider);

    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08),
        child:  AppBar(
          title: SizedBox(
            width: weight * 0.4,
            height: height * 0.07,
            child: Image.asset("assets/images/QAnvas_title.png"),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: weight * 0.02,bottom: height * 0.01),
                child: const Text("ノート",
                  textAlign: TextAlign.start,
                  style:  TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const Divider(color: Colors.black,
              height: 0.5,
            ),
            ValueListenableBuilder(
                valueListenable: Hive.box("Note").listenable(keys:[noteKey]),
                builder: (context, box,widget){
                  return Hive.box("Note").get(noteKey) == null
                    ? Container()
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: Hive.box("Note").get(noteKey).length,
                        itemBuilder: (BuildContext context, int index){
                          return GestureDetector(
                            child: Slidable(
                              child: ListTile(
                                tileColor: Colors.white,
                                title: Text(
                                  Hive.box("Note").get(noteKey)[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context){
                                        noteNotifier.removeNote(noteNotifier.state[index]);
                                        Hive.box("Note").put(noteKey, noteNotifier.state);
                                      },
                                      flex: 1,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                    ),
                                    const SlidableAction(
                                      flex: 1,
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.share,
                                      label: 'Share',
                                    ),
                                  ]
                              ),
                            ),
                            onTap: () {
                              print(Hive.box("Note").get(noteKey)[index]);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(height: 0);
                        },
                  );
                }
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          noteNotifier.addNote("sample2");
          Hive.box("Note").put(noteKey, noteNotifier.state);
        },
      ),
    );
  }


}