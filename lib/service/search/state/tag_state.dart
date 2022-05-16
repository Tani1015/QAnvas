import '../models/tag_model.dart';
import 'package:state_notifier/state_notifier.dart';

class TagState extends StateNotifier<List<TagModel>> with LocatorMixin{
  TagState() : super([]);

  void addTag(TagModel tagmodel){
    if(!state.contains(tagmodel)) {
      state = [...state, tagmodel];
    }
  }

  void removetag(TagModel tagmodel){
    if(state.contains(tagmodel)){
      state = [
        for(final tags in state)
          if(tags.id != tagmodel.id) tags
      ];
    }
  }

}