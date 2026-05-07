import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entities/review_entity.dart';


class ReviewCardWidget extends StatelessWidget {
  final ReviewEntity review;

  const ReviewCardWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            _buildAvatar(),
            SizedBox(width: 7,),
            Text(
              review.user.name,
              style: getRegularStyle(
                fontSize: AppFonts.bodyMedium,
                color: AppColors.darkColor,
              ),
            ),
          ],
        ),

            SizedBox(height: 13,),

            Row(

              children: [

                _buildStars(),
                SizedBox(width: 20,),
                Text(
                  _formatDate(review.createdAt),
                  style: getLightStyle(
                    fontSize: AppFonts.labelSmall,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            const SizedBox(height: 6),
        if (review.comment.isNotEmpty)
          Text(
            review.comment,
            style: getMediumStyle(
              fontSize: 14,
              color: AppColors.textSecondaryColor,
            ),
          ),

      ],
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 22,
      backgroundColor: AppColors.grey,
      backgroundImage: review.user.image != null
          ? NetworkImage(review.user.image!)
          : null,
      child: review.user.image == null
          ? Text(
        review.user.name[0].toUpperCase(),
        style: getBoldStyle(
          fontSize: AppFonts.titleSmall,
          color: AppColors.primaryColor,
        ),
      )
          : null,
    );
  }

  Widget _buildStars() {
    return Row(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Icon(
            index < review.rating.round() ? Icons.star : Icons.star_border,
            color: AppColors.warningColor,
            size: 18,
          ),
        );
      }),
    );
  }

  String _formatDate(String createdAt) {
    final date = DateTime.parse(createdAt);
    final difference = DateTime.now().difference(date);
    if (difference.inDays >= 7) {
      return '${(difference.inDays / 7).floor()} week ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else {
      return 'Today';
    }
  }
}