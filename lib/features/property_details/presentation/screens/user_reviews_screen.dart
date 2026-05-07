import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/snakbar.dart';
import '../../../../core/di.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repos/reviews_repo.dart';
import '../cubit/reviews_cubit.dart';
import '../cubit/reviews_state.dart';
import '../widgets/review_card_widget.dart';

class UserReviewsScreen extends StatelessWidget {
  final int propertyId;
  final double? rate;

  double _calculateRate(List<ReviewEntity> reviews) {
    if (reviews.isEmpty) return 0;
    final total = reviews.fold(0.0, (sum, r) => sum + r.rating);
    return total / reviews.length;
  }

  const UserReviewsScreen({
    super.key,
    required this.propertyId,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => ReviewsCubit(repo: getIt<ReviewsRepo>())
        ..getPropertyReviews(propertyId: propertyId),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_outlined),
          ),
          title: Text(
            'Users Review',
            style: getBoldStyle(
              fontSize: 15,
              color: AppColors.darkColor,
            ),
          ),
        ),
        body: BlocConsumer<ReviewsCubit, ReviewsState>(
          listener: (context, state) {
            if (state is ReviewsFailure) {
              CustomSnackbar(
                AppColors.errorColor,
                state.message,
                true,
              ).show(context);
            }
          },
          builder: (context, state) {
            if (state is ReviewsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }
            if (state is ReviewsSuccess) {
              return Column(
                children: [
                  _buildRatingSummary(state.reviews),
                  const Divider(),
                  Expanded(
                    child: state.reviews.isEmpty
                        ? Center(
                      child: Text(
                        'No reviews yet',
                        style: getLightStyle(
                          fontSize: AppFonts.bodySmall,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                    )
                        : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.reviews.length,
                      separatorBuilder: (_, __) =>
                      const Divider(height: 24),
                      itemBuilder: (_, index) => ReviewCardWidget(
                        review: state.reviews[index],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildRatingSummary(List<ReviewEntity> reviews) {
    final avgRate = _calculateRate(reviews);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.star, color: AppColors.warningColor, size: 22),
          const SizedBox(width: 6),
      Text(
        '${avgRate.toStringAsFixed(1)} / 5.0',
        style: getBoldStyle(
          fontSize: 15,
          color: AppColors.darkColor,
        ),
      ),

          const SizedBox(width: 8),
          Text(
            '  •   ${reviews.length} Reviews',
            style: getLightStyle(
              fontSize: 15,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}