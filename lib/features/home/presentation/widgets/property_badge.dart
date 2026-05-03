import 'package:flutter/material.dart';
import 'package:real_estate_1a/core/constant/custom_svg_image.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';
import 'package:real_estate_1a/gen/assets.gen.dart';


class PropertyBadge extends StatelessWidget {
  final String label;
  final Color color;
  final bool small;

  const PropertyBadge({
    super.key,
    required this.label,
    required this.color,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 5 : 8,
        vertical: small ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(small ? 0.9 : 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children:[
   CustomSvgImage(path: Assets.svg.saleTag)
          ,Text(
          label,
          style: getMediumStyle(fontSize: 10, color: AppColors.black),
        ),
      ]),
    );
  }
}
