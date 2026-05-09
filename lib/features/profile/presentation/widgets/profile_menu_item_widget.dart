import 'package:flutter/material.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';

class ProfileMenuItemWidget extends StatelessWidget {

  final String title;
  final String image;
  final VoidCallback onTap;
  const ProfileMenuItemWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
              Image.asset(image,height: 20,),
            const SizedBox(width: 12,),
            Expanded(
              child: Text(title,
              style: getRegularStyle(
                  fontSize: 16,
                  color: AppColors.black),
              ),
            ),

            Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColors.darkwhite,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}

