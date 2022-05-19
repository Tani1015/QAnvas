import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//クラスインポート
import 'package:qanvas/service/note/state/folder_state.dart';

final folderProvider = StateNotifierProvider<FolderState,List<String>>( (ref)
  => FolderState()
);

class FolderScreen extends HookConsumerWidget{
  const FolderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final folderController = ref.watch(folderProvider);
    final folderNotifier = ref.read(folderProvider.notifier);

    final TextEditingController folderName = TextEditingController();


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
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                         title: const Text("フォルダーを追加"),
                         content: TextField(
                           decoration: const InputDecoration(hintText: "入力してください"),
                           controller: folderName,
                         ),
                          actions: <Widget>[
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
                                folderNotifier.addFolder(folderName.text);
                                Hive.box("Folder").put('Folder', folderNotifier.state);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      }
                  );
                },
                color: Colors.black,
                icon: const Icon(Icons.add)
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: weight * 0.02,bottom: height * 0.01),
                child: const Text("フォルダー",
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
              valueListenable: Hive.box("Folder").listenable(keys: ['Folder']),
              builder: (context, box, widget){
                return Hive.box("Folder").get('Folder') == null
                  ? Container()
                  : ListView.separated(
                  shrinkWrap: true,
                  itemCount: Hive.box("Folder").get('Folder').length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Slidable(
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Text(
                            Hive.box("Folder").get('Folder')[index],
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
                                  Hive.box("Note").delete(folderNotifier.state[index]);
                                  folderNotifier.removeFolder(folderNotifier.state[index]);
                                  Hive.box("Folder").put('Folder', folderNotifier.state);
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
                        context.go('/Note/$index');
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height:  0);
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // GoRouter.of(context).go('/AddQuestion');
          print(folderNotifier.state);
        },
        label:  const Text("ノートを作る"),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

void doNothing(BuildContext context){}