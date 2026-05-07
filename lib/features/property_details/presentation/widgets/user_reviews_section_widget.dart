import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_1a/features/property_details/domain/entities/property_details_entity.dart';
import 'package:real_estate_1a/features/property_details/presentation/widgets/review_card_widget.dart';

import '../../../../core/di.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repos/reviews_repo.dart';
import '../cubit/reviews_cubit.dart';
import '../cubit/reviews_state.dart';
import '../screens/user_reviews_screen.dart';


class UserReviewsSectionWidget extends StatelessWidget {
  final int propertyId;
  final double? rate;
  final List<PropertyImageEntity>propertyImages;

  const UserReviewsSectionWidget({
    super.key,
    required this.propertyId,
    required this.rate, required this.propertyImages,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewsCubit(repo: getIt<ReviewsRepo>())
        ..getPropertyReviews(propertyId: propertyId),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ReviewsCubit, ReviewsState>(
          builder: (context, state) {
            if (state is ReviewsLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
            }
            if (state is ReviewsSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(state.reviews.length,context),
                  const SizedBox(height: 12),
                  _buildImagesRow(),
                  const SizedBox(height: 16),
                  if (state.reviews.isEmpty)
                    Text(
                      'No reviews yet',
                      style: getLightStyle(
                        fontSize: AppFonts.bodySmall,
                        color: AppColors.textSecondaryColor,
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.reviews.length,
                      separatorBuilder: (_, __) => const Divider(height: 24),
                      itemBuilder: (_, index) => ReviewCardWidget(
                        review: state.reviews[index],
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

  Widget _buildHeader(int total,BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'User Reviews',
              style: getBoldStyle(
                fontSize: AppFonts.titleSmall,
                color: AppColors.darkColor,
              ),
            ),

            GestureDetector(
              onTap: (){

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UserReviewsScreen(
                  propertyId: propertyId,
                  rate: rate,
                ),
              ),
            );

            },
              child: Text(
                'See all',
                style: getRegularStyle(
                  fontSize: AppFonts.bodySmall,
                  color: AppColors.primaryColor,
                ),
              ),
            ),

          ],
        ),
       const SizedBox(height: 7,),
        Row(
          children: [

                Image.asset(Assets.icon.staricon.path, height: 16),
            const SizedBox(width: 7),
            Text(
              '${rate ?? 0}  •  $total  Reviews',
              style: getLightStyle(
                fontSize: AppFonts.labelSmall,
                color: AppColors.textSecondaryColor,
              ),
            ),

          ],
        )

      ],
    );
  }

  Widget _buildImagesRow() {
    final images = propertyImages.take(3).toList();
    final remaining = propertyImages.length - images.length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...images.map(
                (img) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  img.url,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (remaining > 0)
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '+$remaining',
                  style: getBoldStyle(
                    fontSize: AppFonts.titleSmall,
                    color: AppColors.darkColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}