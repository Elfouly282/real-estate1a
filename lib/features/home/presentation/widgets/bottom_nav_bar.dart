import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/constant/custom_svg_image.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';

import '../../../../gen/assets.gen.dart';

class AppNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static  final _items = [
    _NavItem(activeImage: Assets.svg.activeHome,     inactiveImage: Assets.svg.inactiveHome,     label: 'Home'),
    _NavItem(activeImage: Assets.svg.activeFavourite, inactiveImage: Assets.svg.favorite, label: 'Favorite'),
    _NavItem(activeImage: Assets.svg.activeMap,      inactiveImage: Assets.svg.map,      label: 'Map'),
    _NavItem(activeImage: Assets.svg.activeHistory,  inactiveImage: Assets.svg.history,  label: 'History'),
    _NavItem(activeImage: Assets.svg.profile,  inactiveImage: Assets.svg.profile,  label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0x0A000000),
        //     blurRadius: 8,
        //     offset: Offset(0, -2),
        //   ),
        // ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _items.length,
                  (i) => _NavBarItem(
                item: _items[i],
                isSelected: currentIndex == i,
                onTap: () => onTap(i),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:  EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.w),
              decoration: BoxDecoration(
                color:Colors.transparent,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CustomSvgImage(
                width: 24.w,
                height: 24.h,
                path:  isSelected ? item.activeImage : item.inactiveImage,
                color: isSelected ?AppColors.primaryColor:Color(0xff1E1E1E),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style:getSemiBold(fontSize: 12, color: isSelected ? AppColors.primaryColor : AppColors.grey,fontWeight: isSelected?FontWeight.w600:FontWeight.normal),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String activeImage;
  final String inactiveImage;
  final String label;

  const _NavItem({
    required this.activeImage,
    required this.inactiveImage,
    required this.label,
  });
}