import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';
import 'package:real_estate_1a/features/favourite/pressentation/cubit/favorites_cubit.dart';
import 'package:real_estate_1a/features/favourite/pressentation/widget/Favorite_card.dart';
import '../../../../../core/di/di.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FavoritesCubit>()..getFavorites(),
      child:  _FavoritesView(),
    );
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();

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
              'Your Favorites',
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
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          // ── Loading ────────────────────────────────────────────────────────
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
          }
          // ── Error ──────────────────────────────────────────────────────────
          if (state is FavoritesError) {
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
                        context.read<FavoritesCubit>().getFavorites(),
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
          if (state is FavoritesSuccess && state.data.properties.isEmpty) {
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

          // ── Success ────────────────────────────────────────────────────────
          if (state is FavoritesSuccess) {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () =>
                  context.read<FavoritesCubit>().getFavorites(),
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: state.data.properties.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, i) {
                  final property = state.data.properties[i];
                  return Stack(
                    children: [
                      FavoriteCard(p: property),
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
