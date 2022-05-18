import 'package:state_notifier/state_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FolderState extends StateNotifier<List<String>> {
  FolderState() : super([]);

  @override
  void initState() {
    state = Hive.box("Folder").get('Folder');
  }

  void addFolder(String foldername) {
    state = [...state, foldername];
  }

  void removeFolder(String foldername) {
    state = [
      for(final file in state)
        if(file != foldername) file
    ];
  }
}