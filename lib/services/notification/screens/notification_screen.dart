import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qanvas/services/notification/controller/notification_controller.dart';

class NotificationScreen extends GetWidget<NotificationController>{
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:  Colors.white,
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
        ),
      ),
    );
  }
}