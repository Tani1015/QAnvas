import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

//クラスインポート
import 'package:qanvas/router/router_provider.dart';

List<Box> boxlist = [];

Future<List<Box>> _openBox() async{
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  //複数のHive Box
  var folderBox = await Hive.openBox("Folder");
  var noteBox = await Hive.openBox("Note");
  var imageBox = await Hive.openBox("Image");
  return boxlist;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _openBox();
  runApp(
    const ProviderScope(
        child: Myapp()
    ),
  );
}

class Myapp extends ConsumerWidget{
  const Myapp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final router = ref.watch(Router_Provider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }

}