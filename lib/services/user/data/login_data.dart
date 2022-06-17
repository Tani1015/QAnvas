import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Gender{
  email,
  password,
}

class LoginProduct extends GetxController{

  final Color enabled;
  final Color enabledtxt;
  final Color background;
  final Color deaible;
  RxBool password = true.obs;
  Gender? selected;

  LoginProduct({
    this.enabled = Colors.blueGrey,
    this.enabledtxt = Colors.white,
    this.background = Colors.grey,
    this.deaible = Colors.black,
  });


  void emailselect() {
    selected = Gender.email;
    update();
  }

}