import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/presentation/custom_hooks/use_effect_once.dart';
import 'package:qanvas/presentation/pages/sample/note/make_note_page.dart';
import 'package:qanvas/presentation/pages/sample/note/select_note_page.dart';

class NotePage extends HookConsumerWidget{
  const NotePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final folderBox = Hive.box("Folder");
    final List<String> emptyList = [];
    final folderList = folderBox.get("Folder");
    final useFolderList = useState<List<dynamic>>(folderList);

    useEffectOnce(() {
      if(folderList == null){
        folderBox.put("Folder", emptyList);
      }
      return null;
    });


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
                valueListenable: folderBox.listenable(keys: ['Folder']),
                builder: (context, box, widget){
                  return folderList.isEmpty == null
                      ? Column(
                    children: [
                      SizedBox(
                        height: height * 0.5,
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.1),
                          child: Image.asset("assets/images/QAnvas_splash2.png"),
                        ),
                      ),
                      const Text("ノートを追加してください!!")
                    ],
                  )
                      : ListView.separated(
                    shrinkWrap: true,
                    itemCount: folderList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Slidable(
                          child: ListTile(
                            tileColor: Colors.white,
                            title: Text(
                              folderList[index],
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
                                    //削除
                                    useFolderList.value.remove(useFolderList.value[index]);
                                    folderBox.put('Folder', useFolderList.value);
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
                          //画面遷移　select
                          SelectNotePage.show(context, index);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(height:  0.5);
                    },
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: height * 0.01),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (_) => const MakeNotePage(),
                ),
              );
              print(useFolderList.value);
              print(folderList);
            },
            label:  const Text("ノートを作る"),
            backgroundColor: Colors.blue,
            heroTag: "folder",
          ),
        )
    );
  }
}