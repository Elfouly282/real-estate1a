import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/home/home_cubit.dart';
import '../cubit/home/home_state.dart';

class FilterChips extends StatelessWidget {
  const FilterChips();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is! HomeSuccess) return const SizedBox.shrink();

        final cubit   = context.read<HomeCubit>();
        final categories = [
          'All',
          ...state.data.categories.map((c) => c.name),
        ];
        return SizedBox(
          height: 36.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length, // ✅
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (_, i) {
              final selected = cubit.selectedFilterIndex == i;
              return GestureDetector(
                onTap: () => cubit.changeFilter(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                      horizontal: 18.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primaryColor
                        : AppColors.babyBlue,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: selected
                          ? AppColors.primaryColor
                          : AppColors.grey2,
                    ),
                  ),
                  child: Text(
                    categories[i],
                    style: getRegularStyle(
                      fontSize: 14,
                      color: selected
                          ? Colors.white
                          : AppColors.primaryColor,
                    ).copyWith(
                      fontWeight:
                      selected ? FontWeight.w600 : FontWeight.normal,
                      fontFamily: AppFonts.Poppins,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
