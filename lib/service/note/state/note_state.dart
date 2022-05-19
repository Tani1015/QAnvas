import 'package:state_notifier/state_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteState extends StateNotifier<List<String>>{
  NoteState(this.keyname) :
        super(keyname == null ? []
              : Hive.box("Note").get(keyname) ?? []
      );

  final String? keyname;

  void addNote(String notename) {
    state = [...state, notename];
  }

  void removeNote(String notename) {
    state = [
      for(final note in state)
        if(note != notename) note
    ];
  }
}