import 'package:get/get.dart';

class RouteController extends GetxController{
  final _tappedIndex = 0.obs;

  set tappedIndex(value) => _tappedIndex.value = value;
  get tappedIndex => _tappedIndex.value;

  void changeTabIndex(int index) {
    tappedIndex = index;
    update();
  }
}