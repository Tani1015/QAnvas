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

class FolderScreen extends StatefulHookConsumerWidget {
  const FolderScreen({Key? key}) : super(key: key);
  @override
  FolderScreenState createState() => FolderScreenState();
}

class FolderScreenState extends ConsumerState<FolderScreen>{

  @override
  Widget build(BuildContext context) {
    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final folderController = ref.watch(folderProvider);
    final folderNotifier = ref.read(folderProvider.notifier);

    final TextEditingController folderName = TextEditingController();
    bool _validate = false;
    List<String> newlist = [];


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
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: weight * 0.05,bottom: height * 0.01),
                child: const Text("フォルダ",
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
                return Hive.box("Folder").get('Folder').isEmpty == true
                  ? Column(
                    children: [
                      SizedBox(
                        height: height * 0.5,
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.1),
                          child: Image.asset("assets/images/QAnvas_splash2.png"),
                        ),
                      ),
                      const Text("フォルダを追加してください!!")
                    ],
                  )
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
                                fontSize: 23,
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
                                  label: '削除',
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
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
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState){
                      return AlertDialog(
                        title: const Text("フォルダを追加"),
                        content: TextField(
                          decoration: InputDecoration(
                            hintText: "入力してください",
                            errorText: _validate ? "空白か同じフォルダーがあります" : null,
                          ),
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
                              setState(() {
                                folderName.text.isEmpty ? _validate = true : Hive.box("Note").containsKey(folderName.text)
                                    ? _validate = true
                                    : {
                                  folderNotifier.addFolder(folderName.text),
                                  Hive.box("Folder").put('Folder', folderNotifier.state),
                                  Hive.box("Note").put(folderName.text, newlist),
                                  Navigator.pop(context)
                                };
                              });
                            },
                          ),
                        ],
                      );
                    }
                );
              }
          );
        },
        label:  const Text("フォルダを作る"),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

void doNothing(BuildContext context){}