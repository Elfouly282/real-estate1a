import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';
import 'package:real_estate_1a/features/favourite/pressentation/cubit/favorites_cubit.dart';
import 'package:real_estate_1a/features/favourite/pressentation/widget/Favorite_card.dart';
import 'package:real_estate_1a/features/history/presentation/cubit/history_cubit.dart';
import 'package:real_estate_1a/features/history/presentation/widget/History_card.dart';
import '../../../../../core/di/di.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HistortyCubit>()..getHistory(),
      child:  _HistoryView(),
    );
  }
}

class _HistoryView extends StatelessWidget {
  const _HistoryView();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your History',
              style: getBoldStyle(fontSize: 18, color: AppColors.black),
            ),
         InkWell(onTap: () {
           
         },
         child: Text("Edit",style: getMediumStyle(fontSize: 14, color:AppColors.primaryColor),),
         )
          ],
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<HistortyCubit, HistoryState>(
        builder: (context, state) {
          // ── Loading ────────────────────────────────────────────────────────
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
          }
          // ── Error ──────────────────────────────────────────────────────────
          if (state is HistoryError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.wifi_off_rounded,
                      size: 48, color: Colors.grey),
                  SizedBox(height: 12.h),
                  Text(state.message,
                      style: getRegularStyle(
                          fontSize: 14, color: Colors.grey)),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<HistortyCubit>().getHistory(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor),
                    child: Text('Retry',
                        style: getRegularStyle(
                            fontSize: 14, color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          // ── Empty ──────────────────────────────────────────────────────────
          if (state is HistorySuccess && state.data.orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star_border,
                      size: 64, color: Colors.grey[300]),
                  SizedBox(height: 16.h),
                  Text('No favorites yet',
                      style: getMediumStyle(
                          fontSize: 16, color: Colors.grey)),
                  SizedBox(height: 8.h),
                  Text('Save properties you like to see them here',
                      style: getRegularStyle(
                          fontSize: 13, color: Colors.grey)),
                ],
              ),
            );
          }
          // ── Success ───────────────────────
          if (state is HistorySuccess) {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () =>
                  context.read<HistortyCubit>().getHistory(),
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: state.data.orders.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, i) {
                  final property = state.data.orders[i];
                  return Stack(
                    children: [
                      HistoryCard(order: state.data.orders[i],),
                    ],
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
