/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/QAnvas_logo.png
  AssetGenImage get qAnvasLogo =>
      const AssetGenImage('assets/images/QAnvas_logo.png');

  /// File path: assets/images/QAnvas_splash.png
  AssetGenImage get qAnvasSplash =>
      const AssetGenImage('assets/images/QAnvas_splash.png');

  /// File path: assets/images/QAnvas_splash2.png
  AssetGenImage get qAnvasSplash2 =>
      const AssetGenImage('assets/images/QAnvas_splash2.png');

  /// File path: assets/images/QAnvas_title.png
  AssetGenImage get QAnvasTitle =>
      const AssetGenImage('assets/images/QAnvas_title.png');

  /// File path: assets/images/buturi.png
  AssetGenImage get buturi => const AssetGenImage('assets/images/buturi.png');

  /// File path: assets/images/eigo.png
  AssetGenImage get eigo => const AssetGenImage('assets/images/eigo.png');

  /// File path: assets/images/kagaku.png
  AssetGenImage get kagaku => const AssetGenImage('assets/images/kagaku.png');

  /// File path: assets/images/keizai.png
  AssetGenImage get keizai => const AssetGenImage('assets/images/keizai.png');

  /// File path: assets/images/kokugo.png
  AssetGenImage get kokugo => const AssetGenImage('assets/images/kokugo.png');

  /// File path: assets/images/rekisi.png
  AssetGenImage get rekisi => const AssetGenImage('assets/images/rekisi.png');

  /// File path: assets/images/sibouko.png
  AssetGenImage get sibouko => const AssetGenImage('assets/images/sibouko.png');

  /// File path: assets/images/sugaku.png
  AssetGenImage get sugaku => const AssetGenImage('assets/images/sugaku.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
