// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:share_plus/share_plus.dart';
//
// import '../../gen/assets.gen.dart';
// import '../constant/custom_svg_image.dart';
//
// class CustomShareButton extends StatelessWidget {
//   final String productName;
//   final String productSlug;
//   final String baseUrl;
//   final Color? color;
//
//   const CustomShareButton({
//     super.key,
//     required this.productName,
//     required this.productSlug,
//     this.baseUrl = 'https://bayoumistore.com',
//     this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         final productUrl = '$baseUrl/product/$productSlug';
//         final shareText = '$productName\n$productUrl';
//         SharePlus.instance.share(ShareParams(text: shareText));
//       },
//       child: CustomSvgImage(path: Assets.svg.share, height: 34.h, width: 34.w),
//     );
//   }
// }
//
//
//
