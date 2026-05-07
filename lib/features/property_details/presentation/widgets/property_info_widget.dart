import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entities/property_details_entity.dart';

class PropertyInfoWidget extends StatelessWidget {
  final PropertyDetailsEntity property;

  const PropertyInfoWidget({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceRow(),
          const SizedBox(height: 12),
          _buildFeaturesRow(),
        ],
      ),
    );
  }

  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              '\$${property.price.toStringAsFixed(0)}',
              style: getBoldStyle(
                fontSize: AppFonts.headlineSmall,
                color: AppColors.darkColor,
              ),
            ),
            const SizedBox(width: 8),
            _buildBadge(),
          ],
        ),
        Image.asset(Assets.icon.rateicon.path, height: 19,color: Colors.black,),
      ],
    );
  }

  Widget _buildBadge() {
    final isSale = property.listingType == 'sale';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: isSale
            ? AppColors.white
            : AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),



      child:
      Row(
        children: [

          Image.asset(
            Assets.icon.saleicon.path,
            height: 16,
          ),


          SizedBox(width: 10,),

          Text(
            isSale
                ? 'For Sale'
                : 'For Rent',
            style: getMediumStyle(
                fontSize: 10, color: isSale ? AppColors.primaryColor : AppColors.successColor),
          ),
        ],
      ),


    );
  }

  Widget _buildFeaturesRow() {
    return Row(
      children: [
        _buildFeatureChip(Assets.icon.bedroomicon.path, '${property.bedrooms} Bedrooms'),
        const SizedBox(width: 8),
        _buildFeatureChip(Assets.icon.bathroomicon.path, '${property.bathrooms} Bathrooms'),
        const SizedBox(width: 8),
        _buildFeatureChip(Assets.icon.kitchanicon.path, '${property.kitchens} Kitchens'),
      ],
    );
  }

  Widget _buildFeatureChip(String iconPath, String label) {
    return Row(
      children: [
        Image.asset(iconPath, height: 16),
        const SizedBox(width: 4),
        Text(
          label,
          style: getLightStyle(
            fontSize: AppFonts.labelSmall,
            color: AppColors.textSecondaryColor,
          ),
        ),
      ],
    );
  }
}