import 'dart:io';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qanvas/model/repositories/package_info/packdge_info_repository.dart';
import 'package:qanvas/model/repositories/shared_preferences/shared_preference_repository.dart';
import 'package:qanvas/model/use_cases/image_compress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/pages/app.dart';


List<Box> boxList = [];

Future<List<Box>> _openBox() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  var boxa = await Hive.openBox("Folder");
  var boxb = await Hive.openBox("Note");
  var boxc = await Hive.openBox("Local");
  boxList.add(boxa);
  boxList.add(boxb);
  boxList.add(boxc);
  return boxList;
}


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  late final PackageInfo packageInfo;
  late final SharedPreferences sharedPreferences;
  late final Directory tempDirectory;

  await _openBox();

  await Future.wait([
    Firebase.initializeApp(),

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]),

    Future(() async {
      packageInfo = await PackageInfo.fromPlatform();
    }),
    Future(() async{
      sharedPreferences = await SharedPreferences.getInstance();
    }),
    Future(() async {
      tempDirectory = await getTemporaryDirectory();
    }),
  ]);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesRepositoryProvider.overrideWithValue(SharedPreferencesRepository(sharedPreferences)),
        packageInfoRepositoryProvider.overrideWithValue(PackageInfoRepository(packageInfo)),
        imageCompressProvider.overrideWithValue(ImageCompress(tempDirectory))
      ],
      child:  const App(),
    ),
  );
}



