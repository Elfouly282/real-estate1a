import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/constant/custom_svg_image.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';
import 'package:real_estate_1a/features/home/domain/entities/home_response_entity.dart';

import '../../../../gen/assets.gen.dart';

class FavoriteCard extends StatelessWidget {
  PropertyEntity p;

  FavoriteCard({super.key, required this.p});

  @override
  Widget build(BuildContext context) {
    final imageUrl = (p.firstImageUrl?.isNotEmpty ?? false)
        ? p.firstImageUrl!
        : 'https://via.placeholder.com/300';
    return Container(
      margin:  EdgeInsets.symmetric(vertical: 4.h),
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
          /// 🖼️ Image + Tag
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p.title.substring(0,20),
                     overflow: TextOverflow.clip,
                     style: getMediumStyle(fontSize: 16, color:Colors.black),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.star,color: Colors.amberAccent,)),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                /// Location
                Row(
                  children: [
                    CustomSvgImage(
                      path: Assets.svg.location,
                      width: 12.w,
                      height: 14.h,
                    ),
                    SizedBox(width: 4),
                    Text(
                      p.address.substring(0,20),
                      overflow: TextOverflow.clip,
                      style: getRegularStyle(color: Colors.grey, fontSize: 10),
                    ),
                    SizedBox(width: 8),
                    Text("|",style: TextStyle(color: AppColors.grey),),

                    SizedBox(width: 4),
                    CustomSvgImage(
                      path: Assets.svg.navigation,
                      width: 12.w,
                      height: 14.h,
                    ),
                    Text(
                     "${p.distanceKm?? '0'} km",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// Features
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _Feature(
                      icon: Icons.living_outlined, text: "${p.bedrooms.toString()} Bedrooms",
                    ),
                    _Feature(
                      icon: Icons.bathtub_outlined,
                      text:"${p.bathrooms.toString()} Bathrooms",
                    ),
                    _Feature(
                      icon: Icons.kitchen_outlined,
                      text: "${p.kitchens.toString()} Kitchens",
                    ),
                  ],
                ),
                 SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _Feature(
                      icon: Icons.bed_outlined, text: "${p.bedrooms.toString()} Bedrooms",
                    ),
                    _Feature(
                      icon: Icons.bathtub_outlined,
                      text:"${p.bathrooms.toString()} Bathrooms",
                    ),
                    _Feature(
                      icon: Icons.kitchen_outlined,
                      text: "${p.kitchens.toString()} Kitchens",
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      p.formattedPrice,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        Text(p.formattedRate),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
