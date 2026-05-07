import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/onboarding_entity.dart';


class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({super.key, required this.entity});

  final OnboardingEntity entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.r),
              bottomRight: Radius.circular(15.r),
            ),
            child: Image.asset(
              entity.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entity.title,
                style: getBoldStyle(
                  fontSize: 19,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                entity.subTitle,
                style: getLightStyle(
                  fontSize: 13,
                  color: AppColors.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
