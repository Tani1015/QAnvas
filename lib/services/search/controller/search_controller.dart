import 'package:get/get.dart';
import 'package:qanvas/services/search/models/tag_model.dart';

class SearchController extends GetxController{

  RxList? tagList = [].obs;

  final List<TagModel>? tagsToSelect = [
    TagModel(id: '1', title: 'JavaScript'),
    TagModel(id: '2', title: 'Python'),
    TagModel(id: '3', title: 'Java'),
    TagModel(id: '4', title: 'PHP'),
    TagModel(id: '5', title: 'C#'),
    TagModel(id: '6', title: 'C++'),
    TagModel(id: '7', title: 'Dart'),
    TagModel(id: '8', title: 'DataFlex'),
    TagModel(id: '9', title: 'Flutter'),
    TagModel(id: '10', title: 'Flutter Selectable Tags'),
    TagModel(id: '11', title: 'Android Studio developer'),
    TagModel(id: '12', title: 'J'),
    TagModel(id: '13', title: 'P'),
    TagModel(id: '14', title: 'Js'),
    TagModel(id: '15', title: 'PH'),
    TagModel(id: '16', title: 'D#'),
    TagModel(id: '17', title: 'D++'),
    TagModel(id: '18', title: 'Da'),
    TagModel(id: '19', title: 'Dat'),
    TagModel(id: '20', title: 'Flur'),
    TagModel(id: '21', title: 'Flu Selectable Tags'),
    TagModel(id: '22', title: 'And Studio developer'),
    TagModel(id: '1', title: 'JavaScript'),
    TagModel(id: '2', title: 'Python'),
    TagModel(id: '3', title: 'Java'),
    TagModel(id: '4', title: 'PHP'),
    TagModel(id: '5', title: 'C#'),
    TagModel(id: '6', title: 'C++'),
    TagModel(id: '7', title: 'Dart'),
    TagModel(id: '8', title: 'DataFlex'),
    TagModel(id: '9', title: 'Flutter'),
    TagModel(id: '10', title: 'Flutter Selectable Tags'),
    TagModel(id: '11', title: 'Android Studio developer'),
    TagModel(id: '12', title: 'J'),
    TagModel(id: '13', title: 'P'),
    TagModel(id: '14', title: 'Js'),
    TagModel(id: '15', title: 'PH'),
    TagModel(id: '16', title: 'D#'),
    TagModel(id: '17', title: 'D++'),
    TagModel(id: '18', title: 'Da'),
    TagModel(id: '19', title: 'Dat'),
    TagModel(id: '20', title: 'Flur'),
    TagModel(id: '21', title: 'Flu Selectable Tags'),
    TagModel(id: '22', title: 'And Studio developer'),
  ].obs;


  void addTag(TagModel tagModel){
    tagList?.add(tagModel);
  }

  void removeTag(TagModel tagModel){
    tagList?.remove(tagModel);
  }

}