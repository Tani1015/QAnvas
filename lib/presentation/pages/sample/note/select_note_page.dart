import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectNotePage extends HookConsumerWidget{
  const SelectNotePage(this.index, {Key? key}) : super(key: key);

  final int index;

  static Future<void> show(BuildContext context, int index) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => SelectNotePage(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final folderBox = Hive.box("Folder");
    final noteBox = Hive.box("Note");
    final folderList = folderBox.get("Folder");
    final useFolderList = useState<List<String>>(folderList);
    final image = noteBox.get(useFolderList.value[index]);

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
                child: Text(useFolderList.value[index],
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
            Container(
              margin: const EdgeInsets.all(15),
              height: height * 0.70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)
              ),
              child: Center(
                child: Container(
                  height: height * 0.7,
                  width: weight * 0.8,
                  child: Image.memory(image),
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}