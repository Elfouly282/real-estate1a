import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/features/home/domain/entities/home_response_entity.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../pages/star_rating.dart';

class NearestPropertyCard extends StatefulWidget {
  final PropertyEntity property;

  const NearestPropertyCard({super.key, required this.property});

  @override
  State<NearestPropertyCard> createState() => _NearestPropertyCardState();
}

class _NearestPropertyCardState extends State<NearestPropertyCard> {
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.property;

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          _buildThumbnail(p),
          SizedBox(width: 10.w),
          Expanded(child: _buildInfo(p)),
        ],
      ),
    );
  }

  Widget _buildThumbnail(PropertyEntity p) {
    final imageUrl = (p.firstImageUrl?.isNotEmpty ?? false)
        ? p.firstImageUrl!
        : 'https://via.placeholder.com/300';

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 147.w,
        height: 151.h,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (_, __, ___) => Container(
          color: Colors.grey[200],
          child: Icon(
            Icons.home_rounded,
            color: Colors.grey[400],
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(PropertyEntity p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + Favorite
        Row(
          children: [
            Expanded(
              child: Text(
                p.title,
                style: getMediumStyle(fontSize: 14, color: AppColors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _saved = !_saved),
              child: Icon(
                _saved ? Icons.star : Icons.star_border,
                size: 20.sp,
                color: _saved ? AppColors.yello : Colors.grey,
              ),
            ),
          ],
        ),

        SizedBox(height: 4.h),

        // Address + Distance
        Row(
          children: [
            Icon(Icons.location_on,
                color: AppColors.primaryColor, size: 12),

            SizedBox(width: 4.w),

            Expanded(
              child: Text(
                p.address ?? '',
                style: getRegularStyle(
                  fontSize: 11,
                  color: AppColors.primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(width: 6.w),

            Icon(Icons.near_me_outlined,
                size: 10, color: Colors.grey),

            SizedBox(width: 3.w),

            Text(
              "${p.latitude?.toStringAsFixed(1) ?? '0'} km",
              style: getRegularStyle(
                fontSize: 10,
                color: AppColors.grey2,
              ),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Price + Rating
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              p.formattedPrice,
              style: getSemiBold(
                fontSize: 14,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            StarRating(rating: 5 ?? 0),
          ],
        ),
      ],
    );
  }
}