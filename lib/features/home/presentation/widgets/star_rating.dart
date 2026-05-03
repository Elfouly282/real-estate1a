import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class StarRating extends StatelessWidget {
  final double rating;
  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: AppColors.yello, size: 14),
        const SizedBox(width: 2),
        Text(
          rating.toString(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.grey2,
          ),
        ),
      ],
    );
  }
}
