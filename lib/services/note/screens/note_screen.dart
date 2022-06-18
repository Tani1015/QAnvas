import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qanvas/services/note/controller/folder_controller.dart';


//クラスインポート
import '../controller/note_controller.dart';

class NoteScreen extends GetWidget{
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int? index = Get.arguments;
    final folderProvider = Get.put(FolderController());
    final noteKey = folderProvider.folderList![index!];
    final noteProvider = Get.put(NoteController(noteKey));

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
                padding: EdgeInsets.only(left: weight * 0.05,bottom: height * 0.01),
                child: Text(Hive.box("Folder").getAt(0)[index],
                  textAlign: TextAlign.start,
                  style:  const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const Divider(color: Colors.black,
              height: 1,
            ),
            ValueListenableBuilder(
                valueListenable: Hive.box("Note").listenable(keys:[noteKey]),
                builder: (context, box,widget){
                  return Hive.box("Note").get(noteKey).isEmpty == true
                    ? Column(
                      children: [
                        SizedBox(
                          height: height * 0.5,
                          child: Padding(
                            padding: EdgeInsets.only(top: height * 0.1),
                            child: Image.asset("assets/images/QAnvas_logo.png"),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        const Text("ノートを追加してください!!")
                      ],
                    )
                    :ListView.separated(
                    shrinkWrap: true,
                    itemCount: Hive.box('Note').get(noteKey).length,
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        child: Slidable(
                          child: Container(
                              margin: const EdgeInsets.all(20),
                              height: height * 0.75,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: height* 0.05),
                                    Container(
                                      height: height * 0.6,
                                      width: weight * 0.8,
                                      child: Image.memory(Hive.box('Note').get(noteKey)[index]),
                                      //[Hive.box('Note').get(noteKey).keys.elementAt(index)]
                                      color: Colors.white,
                                    ),
                                    // ListTile(
                                    //   tileColor: Colors.white,
                                    //   title: Text(
                                    //       Hive.box("Note").get(noteKey).keys.elementAt(index).toString(),
                                    //     textAlign: TextAlign.left,
                                    //     style: const TextStyle(
                                    //       fontSize: 23,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )
                          ),
                          endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (BuildContext context){
                                    Hive.box('Note').get(noteKey).keys.elementAt(index);
                                    Hive.box("Note").get(noteKey).remove(Hive.box('Note').get(noteKey)[index]);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Get.toNamed('/MakeNote',arguments: index);
          print(noteProvider.noteList);
        },
        label:  const Text("ノートを作る"),
        backgroundColor: Colors.red,
      ),
    );

  }
}

void doNothing(BuildContext context){}