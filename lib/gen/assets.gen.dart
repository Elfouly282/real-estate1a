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

  AssetGenImage get appleicon =>
      const AssetGenImage('assets/icon/appleicon.png');
  AssetGenImage get arrowback =>
      const AssetGenImage('assets/icon/arrowback.png');
  AssetGenImage get backyardicon =>
      const AssetGenImage('assets/icon/backyardicon.png');
  AssetGenImage get bathroomicon =>
      const AssetGenImage('assets/icon/bathroomicon.png');
  AssetGenImage get bedroomicon =>
      const AssetGenImage('assets/icon/bedroomicon.png');
  AssetGenImage get call => const AssetGenImage('assets/icon/call.png');
  AssetGenImage get distanceicon =>
      const AssetGenImage('assets/icon/distanceicon.png');
  AssetGenImage get familyroom =>
      const AssetGenImage('assets/icon/familyroom.png');
  AssetGenImage get garagicon =>
      const AssetGenImage('assets/icon/garagicon.png');
  AssetGenImage get googleicon =>
      const AssetGenImage('assets/icon/googleicon.png');
  AssetGenImage get kitchanicon =>
      const AssetGenImage('assets/icon/kitchanicon.png');
  AssetGenImage get livingicon =>
      const AssetGenImage('assets/icon/livingicon.png');
  AssetGenImage get locationicon =>
      const AssetGenImage('assets/icon/locationicon.png');
  AssetGenImage get loggo => const AssetGenImage('assets/icon/loggo.png');
  AssetGenImage get logo1 => const AssetGenImage('assets/icon/logo1.png');
  AssetGenImage get logo2 => const AssetGenImage('assets/icon/logo2.png');
  String get logoo => 'assets/icon/logoo.svg';
  AssetGenImage get message => const AssetGenImage('assets/icon/message.png');
  AssetGenImage get rateicon => const AssetGenImage('assets/icon/rateicon.png');
  AssetGenImage get saleicon => const AssetGenImage('assets/icon/saleicon.png');
  AssetGenImage get shareicon =>
      const AssetGenImage('assets/icon/shareicon.png');
  AssetGenImage get staricon => const AssetGenImage('assets/icon/staricon.png');
  AssetGenImage get stariconn =>
      const AssetGenImage('assets/icon/stariconn.png');

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

  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding1.png');
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding2.jpeg');
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding3.jpeg');

  List<AssetGenImage> get values => [onboarding1, onboarding2, onboarding3];
}

class $AssetsPngGen {
  const $AssetsPngGen();

  AssetGenImage get profile => const AssetGenImage('assets/png/profile.png');

  List<AssetGenImage> get values => [profile];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  String get frame2147225639 => 'assets/svg/Frame 2147225639.svg';
  String get navigation => 'assets/svg/Navigation.svg';
  String get activeFavourite => 'assets/svg/active_favourite.svg';
  String get activeHistory => 'assets/svg/active_history.svg';
  String get activeHome => 'assets/svg/active_home.svg';
  String get activeMap => 'assets/svg/active_map.svg';
  String get activeMessage => 'assets/svg/active_message.svg';
  String get activeNotification => 'assets/svg/active_notification.svg';
  String get favorite => 'assets/svg/favorite.svg';
  String get filter => 'assets/svg/filter.svg';
  String get history => 'assets/svg/history.svg';
  String get inactiveHome => 'assets/svg/inactive_home.svg';
  String get inactiveMessage => 'assets/svg/inactive_message.svg';
  String get inactiveNotification => 'assets/svg/inactive_notification.svg';
  String get location => 'assets/svg/location.svg';
  String get map => 'assets/svg/map.svg';
  String get profile => 'assets/svg/profile.svg';
  String get saleTag => 'assets/svg/sale-tag.svg';

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

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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
