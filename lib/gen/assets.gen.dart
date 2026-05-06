// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/appleicon.png
  AssetGenImage get appleicon =>
      const AssetGenImage('assets/icon/appleicon.png');

  /// File path: assets/icon/arrowback.png
  AssetGenImage get arrowback =>
      const AssetGenImage('assets/icon/arrowback.png');

  /// File path: assets/icon/backyardicon.png
  AssetGenImage get backyardicon =>
      const AssetGenImage('assets/icon/backyardicon.png');

  /// File path: assets/icon/bathroomicon.png
  AssetGenImage get bathroomicon =>
      const AssetGenImage('assets/icon/bathroomicon.png');

  /// File path: assets/icon/bedroomicon.png
  AssetGenImage get bedroomicon =>
      const AssetGenImage('assets/icon/bedroomicon.png');

  /// File path: assets/icon/call.png
  AssetGenImage get call => const AssetGenImage('assets/icon/call.png');

  /// File path: assets/icon/distanceicon.png
  AssetGenImage get distanceicon =>
      const AssetGenImage('assets/icon/distanceicon.png');

  /// File path: assets/icon/familyroom.png
  AssetGenImage get familyroom =>
      const AssetGenImage('assets/icon/familyroom.png');

  /// File path: assets/icon/garagicon.png
  AssetGenImage get garagicon =>
      const AssetGenImage('assets/icon/garagicon.png');

  /// File path: assets/icon/googleicon.png
  AssetGenImage get googleicon =>
      const AssetGenImage('assets/icon/googleicon.png');

  /// File path: assets/icon/kitchanicon.png
  AssetGenImage get kitchanicon =>
      const AssetGenImage('assets/icon/kitchanicon.png');

  /// File path: assets/icon/livingicon.png
  AssetGenImage get livingicon =>
      const AssetGenImage('assets/icon/livingicon.png');

  /// File path: assets/icon/locationicon.png
  AssetGenImage get locationicon =>
      const AssetGenImage('assets/icon/locationicon.png');

  /// File path: assets/icon/loggo.png
  AssetGenImage get loggo => const AssetGenImage('assets/icon/loggo.png');

  /// File path: assets/icon/logo1.png
  AssetGenImage get logo1 => const AssetGenImage('assets/icon/logo1.png');

  /// File path: assets/icon/logo2.png
  AssetGenImage get logo2 => const AssetGenImage('assets/icon/logo2.png');

  /// File path: assets/icon/logoo.svg
  String get logoo => 'assets/icon/logoo.svg';

  /// File path: assets/icon/message.png
  AssetGenImage get message => const AssetGenImage('assets/icon/message.png');

  /// File path: assets/icon/rateicon.png
  AssetGenImage get rateicon => const AssetGenImage('assets/icon/rateicon.png');

  /// File path: assets/icon/saleicon.png
  AssetGenImage get saleicon => const AssetGenImage('assets/icon/saleicon.png');

  /// File path: assets/icon/shareicon.png
  AssetGenImage get shareicon =>
      const AssetGenImage('assets/icon/shareicon.png');

  /// File path: assets/icon/staricon.png
  AssetGenImage get staricon => const AssetGenImage('assets/icon/staricon.png');

  /// File path: assets/icon/stariconn.png
  AssetGenImage get stariconn =>
      const AssetGenImage('assets/icon/stariconn.png');

  /// List of all assets
  List<dynamic> get values => [
    appleicon,
    arrowback,
    backyardicon,
    bathroomicon,
    bedroomicon,
    call,
    distanceicon,
    familyroom,
    garagicon,
    googleicon,
    kitchanicon,
    livingicon,
    locationicon,
    loggo,
    logo1,
    logo2,
    logoo,
    message,
    rateicon,
    saleicon,
    shareicon,
    staricon,
    stariconn,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/onboarding1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding1.png');

  /// File path: assets/images/onboarding2.jpeg
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding2.jpeg');

  /// File path: assets/images/onboarding3.jpeg
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding3.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [onboarding1, onboarding2, onboarding3];
}

class Assets {
  const Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
