// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/profile.png
  AssetGenImage get profile => const AssetGenImage('assets/png/profile.png');

  /// List of all assets
  List<AssetGenImage> get values => [profile];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/Frame 2147225639.svg
  String get frame2147225639 => 'assets/svg/Frame 2147225639.svg';

  /// File path: assets/svg/Navigation.svg
  String get navigation => 'assets/svg/Navigation.svg';

  /// File path: assets/svg/active_favourite.svg
  String get activeFavourite => 'assets/svg/active_favourite.svg';

  /// File path: assets/svg/active_history.svg
  String get activeHistory => 'assets/svg/active_history.svg';

  /// File path: assets/svg/active_home.svg
  String get activeHome => 'assets/svg/active_home.svg';

  /// File path: assets/svg/active_map.svg
  String get activeMap => 'assets/svg/active_map.svg';

  /// File path: assets/svg/active_message.svg
  String get activeMessage => 'assets/svg/active_message.svg';

  /// File path: assets/svg/active_notification.svg
  String get activeNotification => 'assets/svg/active_notification.svg';

  /// File path: assets/svg/favorite.svg
  String get favorite => 'assets/svg/favorite.svg';

  /// File path: assets/svg/filter.svg
  String get filter => 'assets/svg/filter.svg';

  /// File path: assets/svg/history.svg
  String get history => 'assets/svg/history.svg';

  /// File path: assets/svg/inactive_home.svg
  String get inactiveHome => 'assets/svg/inactive_home.svg';

  /// File path: assets/svg/inactive_message.svg
  String get inactiveMessage => 'assets/svg/inactive_message.svg';

  /// File path: assets/svg/inactive_notification.svg
  String get inactiveNotification => 'assets/svg/inactive_notification.svg';

  /// File path: assets/svg/location.svg
  String get location => 'assets/svg/location.svg';

  /// File path: assets/svg/map.svg
  String get map => 'assets/svg/map.svg';

  /// File path: assets/svg/profile.svg
  String get profile => 'assets/svg/profile.svg';

  /// File path: assets/svg/sale-tag.svg
  String get saleTag => 'assets/svg/sale-tag.svg';

  /// List of all assets
  List<String> get values => [
    frame2147225639,
    navigation,
    activeFavourite,
    activeHistory,
    activeHome,
    activeMap,
    activeMessage,
    activeNotification,
    favorite,
    filter,
    history,
    inactiveHome,
    inactiveMessage,
    inactiveNotification,
    location,
    map,
    profile,
    saleTag,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
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
