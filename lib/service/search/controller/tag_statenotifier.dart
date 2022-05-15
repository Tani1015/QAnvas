import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

//クラスインポート
import '../models/tag_state.dart';
import '../models/tag_model.dart';

class TagStateNotifier extends StateNotifier<TagState> with LocatorMixin{
  TagStateNotifier() : super(const TagState());

  void addTags(TagModel tagModel) {
    final currentState = state;
    if(!state.tagList.contains(tagModel)) {
      final tags = currentState.tagList.toList()
        ..add(tagModel);
      state = state.copyWith(tagList: tags);
    }
  }

  void removeTag(TagModel tagModel) async {
    final currentState = state;
    if (state.tagList.contains(tagModel)) {
      final tags = currentState.tagList.toList()
        ..remove(tagModel);
      state = state.copyWith(tagList: tags);
    }
  }

}