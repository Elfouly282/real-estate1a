import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/constant/custom_svg_image.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';
import 'package:real_estate_1a/features/history/domain/entities/history_entity.dart';
import '../../../../gen/assets.gen.dart';

class HistoryCard extends StatelessWidget {
  final OrderEntity order;

  const HistoryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final p = order.property;

    final imageUrl = (p.firstImageUrl?.isNotEmpty ?? false)
        ? p.firstImageUrl!
        : 'https://via.placeholder.com/300';

    String safeSubstring(String? text) {
      if (text == null) return '';
      return text.length > 20 ? text.substring(0, 20) : text;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: AppColors.grey, blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) =>
                  Container(height: 180.h, color: Colors.grey[200]),
              errorWidget: (_, __, ___) => Container(
                height: 180.h,
                color: Colors.grey[200],
                child: const Icon(Icons.home_rounded, color: Colors.grey, size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        safeSubstring(p.title),
                        overflow: TextOverflow.ellipsis,
                        style: getMediumStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Icon(Icons.star, size: 24.sp, color: Colors.amberAccent),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    CustomSvgImage(path: Assets.svg.location, width: 12.w, height: 14.h),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        safeSubstring(p.address),
                        overflow: TextOverflow.ellipsis,
                        style: getRegularStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text("|", style: TextStyle(color: AppColors.grey)),
                    const SizedBox(width: 6),
                    CustomSvgImage(path: Assets.svg.navigation, width: 12.w, height: 14.h),
                    Text("${p.distanceKm ?? 0} km",
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _Feature(icon: Icons.access_time, text: order.formattedDate),
                    _Feature(icon: Icons.bed_outlined, text: "${p.bedrooms} BedRooms"),
                    _Feature(icon: Icons.bathtub_outlined, text: "${p.bathrooms} Bath"),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(p.formattedPrice,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(p.formattedRate),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _statusColor(order.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    order.statusLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _statusColor(order.status),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'completed': return Colors.green;
      case 'cancelled': return Colors.red;
      case 'pending':   return Colors.orange;
      default:          return Colors.grey;
    }
  }
}

class _Feature extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Feature({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}