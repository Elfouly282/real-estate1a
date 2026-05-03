import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/constant/custom_svg_image.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';
import 'package:real_estate_1a/features/home/domain/entities/home_response_entity.dart';
import 'package:real_estate_1a/features/home/presentation/widgets/property_badge.dart';
import 'package:real_estate_1a/gen/assets.gen.dart';
import '../../../../core/utils/app_colors.dart';
import 'star_rating.dart';

class BestOfferCard extends StatefulWidget {
  final PropertyEntity property;

  const BestOfferCard({super.key, required this.property});

  @override
  State<BestOfferCard> createState() => _BestOfferCardState();
}

class _BestOfferCardState extends State<BestOfferCard> {
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.property;

    return Container(
      width: 227.w,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(p),
          _buildInfo(p),
        ],
      ),
    );
  }

  Widget _buildImage(PropertyEntity p) {
    final imageUrl = (p.firstImageUrl?.isNotEmpty ?? false)
        ? p.firstImageUrl!
        : 'https://via.placeholder.com/300';

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          height: 147.h,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            height: 147.h,
            color: Colors.grey[200],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (_, __, ___) => Container(
            height: 147.h,
            color: Colors.grey[200],
            child: Icon(
              Icons.home_rounded,
              color: Colors.grey[400],
              size: 40,
            ),
          ),
        ),

        // Badge
        Positioned(
          top: 8.h,
          left: 8.w,
          child: PropertyBadge(
            label: p.tagLabel,
            color: AppColors.black,
          ),
        ),


      ],
    );
  }

  Widget _buildInfo(PropertyEntity p) {
    return Padding(
      padding: EdgeInsets.all(9.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                p.title.substring(0,20),
                style: getMediumStyle(fontSize: 13, color: AppColors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Favorite

                GestureDetector(
                  onTap: () => setState(() => _saved = !_saved),
                  child: Icon(
                    _saved ? Icons.star : Icons.star_border,
                    size: 24.sp,
                    color: _saved ? AppColors.yello : Colors.grey,

                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          // Address + Distance
          Row(
            children: [
              CustomSvgImage(
                path: Assets.svg.location,
                width: 12.w,
                height: 12.h,
              ),
              SizedBox(width: 4.w),

              Expanded(
                child: Text(
                  p.address ?? '',
                  style: getRegularStyle(
                    fontSize: 10,
                    color: AppColors.grey2,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),

              SizedBox(width: 6.w),

              CustomSvgImage(path: Assets.svg.navigation),

              SizedBox(width: 4.w),

              Text(
                "${p.distanceKm?? '0'} km",
                style: getRegularStyle(
                  fontSize: 10,
                  color: AppColors.grey2,
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // Price + Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  p.formattedPrice,
                  style: getSemiBold(
                    fontSize: 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              StarRating(rating: p.rate ?? 0),
            ],
          ),
        ],
      ),
    );
  }
}