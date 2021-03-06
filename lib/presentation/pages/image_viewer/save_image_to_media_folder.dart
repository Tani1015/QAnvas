import 'dart:io';
import 'dart:typed_data';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qanvas/presentation/widgets/show_indicator.dart';




Future<void> saveImageToMediaFolder(
    BuildContext context,
    Uint8List imageBytes,
    ) async {
  final status = await Future(() async {
    return Platform.isIOS
        ? Permission.photos.request()
        : Permission.storage.request();
  });
  if (!status.isGranted) {
    final result = await showOkAlertDialog(
      context: context,
      title: '写真のパーミッション',
      message: 'アプリの設定画面より写真のアクセスを許可してください。',
      okLabel: '設定画面を開く',
    );
    if (result == OkCancelResult.ok) {
      await openAppSettings();
    }
    return;
  }

  try {
    showIndicator(context);
    await ImageGallerySaver.saveImage(imageBytes);
  } on Exception catch (_) {
  }
  dismissIndicator(context);
}