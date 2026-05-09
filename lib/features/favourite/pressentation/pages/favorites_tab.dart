import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';
import 'package:real_estate_1a/features/favourite/pressentation/cubit/favorites_cubit.dart';
import 'package:real_estate_1a/features/favourite/pressentation/widget/Favorite_card.dart';
import '../../../../../core/di/di.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FavoritesCubit>()..getFavorites(),
      child:  _FavoritesView(),
    );
  }
}

class _FavoritesView extends StatefulWidget {
  const _FavoritesView();

  @override
  State<_FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<_FavoritesView> {
  bool isEditMode = false;

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
              style: getBoldStyle(
                fontSize: 18,
                color: AppColors.black,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isEditMode = !isEditMode;
                });
              },
              child: Text(
                isEditMode ? "Done" : "Edit",
                style: getMediumStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),

      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state is FavoritesError) {
            return Center(child: Text(state.message));
          }

          if (state is FavoritesSuccess &&
              state.data.properties.isEmpty) {
            return const Center(child: Text("No favorites yet"));
          }

          if (state is FavoritesSuccess) {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () =>
                  context.read<FavoritesCubit>().getFavorites(),
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: state.data.properties.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: 12.h),
                itemBuilder: (_, i) {
                  final property = state.data.properties[i];

                  return Stack(
                    children: [
                      FavoriteCard(p: property),

                      if (isEditMode)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<FavoritesCubit>()
                                  .removeFromFavorite(property.id);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
