import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/appbar/app_bar_cubit.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/home/home_state.dart';
import 'package:real_estate_1a/features/home/presentation/widgets/best_offer_card.dart';
import 'package:real_estate_1a/features/home/presentation/widgets/home_app_bar.dart';
import 'package:real_estate_1a/features/home/presentation/widgets/search_bar.dart';
import '../../../../../core/di/di.dart';
import '../../widgets/filter_chips_widget.dart';
import '../../widgets/nearest_property_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AppBarCubit>()),
        BlocProvider(create: (_) => getIt<HomeCubit>()..getHomeData()),
      ],
      child: const _HomeTabView(),
    );
  }
}

class _HomeTabView extends StatelessWidget {
  const _HomeTabView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBarCubit, AppBarState>(
      listenWhen: (prev, curr) =>
      curr.locationStatus == LocationStatus.loaded &&
          prev.locationStatus != LocationStatus.loaded,
      listener: (context, appBarState) {
        if (appBarState.latitude != null && appBarState.longitude != null) {
          context.read<HomeCubit>().sortNearby(
            userLat: appBarState.latitude!,
            userLng: appBarState.longitude!,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const HomeAppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              const SearchBarWidget(),
              SizedBox(height: 16.h),
              const FilterChips(),
              SizedBox(height: 20.h),
              const _HomeContent(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off_rounded,
                    size: 48, color: Colors.grey),
                SizedBox(height: 12.h),
                Text(state.message,
                    style:
                    getRegularStyle(fontSize: 14, color: Colors.grey)),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () =>
                      context.read<HomeCubit>().getHomeData(),
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

        if (state is HomeSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Best Offers ───────────────────────────────────────────────
              _SectionHeader(title: 'Best Offers', onViewAll: () {}),
              SizedBox(height: 12.h),
              SizedBox(
                height: 260.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.data.bestSelling.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (_, i) =>
                      GestureDetector(child: BestOfferCard(property: state.data.bestSelling[i]),onTap: (){},),
                ),
              ),
              SizedBox(height: 20.h),

              // ── Nearest You ───────────────────────────────────────────────
              _SectionHeader(title: 'Nearest You', onViewAll: () {}),
              SizedBox(height: 12.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.data.recommended.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, i) =>
                 GestureDetector(child: NearestPropertyCard(property:state.data.recommended[i]),onTap: (){},),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeader({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: getBoldStyle(fontSize: 16, color: AppColors.black)),
        GestureDetector(
          onTap: onViewAll,
          child: Text('View All',
              style: getRegularStyle(
                  fontSize: 13, color: AppColors.primaryColor)),
        ),
      ],
    );
  }
}