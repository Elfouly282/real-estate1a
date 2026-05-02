import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/constant/custom_svg_image.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';

import '../../../../gen/assets.gen.dart';
import '../cubit/appbar/app_bar_cubit.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(80.h); // ✅ صلّحناها
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
    super.initState();
    context.read<AppBarCubit>().fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBarCubit, AppBarState>(
      builder: (context, state) => AppBar(
        toolbarHeight: 80.h,
        backgroundColor: AppColors.backgroundColor,
          title: Row(
      children: [
      CustomSvgImage(
      path: Assets.svg.location,
        width: 32.w,
        height: 32.h,
      ),
      SizedBox(width: 8.w),
      Expanded(           // ← أضف Expanded هنا
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: getRegularStyle(fontSize: 14, color: AppColors.grey2),
            ),
            if (state.locationStatus == LocationStatus.loading)
              SizedBox(
                width: 14.w,
                height: 14.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.black,
                ),
              )
            else
              Text(
                state.location.isEmpty ? 'Locating...' : state.location,
                style: getRegularStyle(fontSize: 14, color: AppColors.black),
                overflow: TextOverflow.ellipsis,  // ← أضف عشان متكسرش
              ),
          ],
        ),
      ),
      ],
    ),
        actions: [
          GestureDetector(
            onTap: () => context.read<AppBarCubit>().clearNotification(),
            child: CustomSvgImage(
              path: state.hasNotification
                  ? Assets.svg.activeNotification
                  : Assets.svg.inactiveNotification,
            ),
          ),
          SizedBox(width: 16.w),
          GestureDetector(
            onTap: () => context.read<AppBarCubit>().clearMessage(),
            child: CustomSvgImage(
              path: state.hasMessage
                  ? Assets.svg.activeMessage
                  : Assets.svg.inactiveMessage,
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }
}