import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Gender{
  fullName,
  email,
  password,
  confirmpassword,
  phone
}

class SignUpProduct extends GetxController{

  final Color enabled;
  final Color enabledTxt;
  final Color background;
  final Color deaible;
  RxBool password = true.obs;
  RxBool confPassword = true.obs;
  Gender? selected;

  SignUpProduct({
    this.enabled = Colors.blueGrey,
    this.enabledTxt = Colors.white,
    this.background = Colors.grey,
    this.deaible = Colors.black,
  });

  void nameselect() {
    selected = Gender.fullName;
    update();
  }

  void phoneselect() {
    selected = Gender.phone;
    update();
  }


  void emailselect() {
    selected = Gender.email;
    update();
  }

  void passselect() {
    selected = Gender.password;
    update();
  }

  void confpassselect() {
    selected = Gender.confirmpassword;
    update();
  }
}