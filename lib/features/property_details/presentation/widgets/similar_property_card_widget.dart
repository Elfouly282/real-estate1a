import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../favourite/pressentation/cubit/favorites_cubit.dart';
import '../../domain/entities/property_details_entity.dart';

class SimilarPropertyCardWidget extends StatefulWidget {
  final PropertyDetailsEntity property;

  const SimilarPropertyCardWidget({
    super.key,
    required this.property,
  });

  @override
  State<SimilarPropertyCardWidget> createState() => _SimilarPropertyCardWidgetState();
}

class _SimilarPropertyCardWidgetState extends State<SimilarPropertyCardWidget> {
  bool isFavourite=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleRow(),
                const SizedBox(height: 10),
                _buildLocationRow(),
                const SizedBox(height: 10),
                _buildFeaturesRow(),
                const SizedBox(height: 16),
                _buildPriceRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          child: Image.network(
            widget.property.images.isNotEmpty ? widget.property.images.first.url : '',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 180,
              color: AppColors.grey,
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: _buildBadge(),
        ),

      ],
    );
  }

  Widget _buildBadge() {
    final isSale = widget.property.listingType == 'sale';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child:
      Row(
        children: [

          Image.asset(
            Assets.icon.saleicon.path,
            height: 16,
          ),
          SizedBox(width: 5,),
          Text(
            isSale ? 'For Sale' : 'For Rent',
            style: getRegularStyle(
              fontSize: AppFonts.labelSmall,
              color: AppColors.black,
            ),
          ),
        ],
      )


    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.property.title,
            style: getBoldStyle(
              fontSize: AppFonts.bodyMedium,
              color: AppColors.darkColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

        ),
        GestureDetector(
            onTap: () {
              setState(() => isFavourite = !isFavourite);
              context.read<FavoritesCubit>().toggleFavorite(widget.property.id);

              //  context.read<FavoritesCubit>().toggleFavorite(widget.property.id);
            },
          child: Icon(
            isFavourite ?Icons.star_rate : Icons.star_rate_outlined   ,
            color: isFavourite ? Colors.amber : AppColors.darkColor,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        Image.asset(Assets.icon.locationicon.path, height: 14,color: AppColors.primaryColor,),
        const SizedBox(width: 4),
        Expanded(
          child: Row(
            children: [
              Text(
                widget.property.address.length>20?widget.property.address.substring(0,20):widget.property.address
                ,style: getLightStyle(
                  fontSize: AppFonts.labelSmall,
                  color: AppColors.textSecondaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (widget.property.distanceKm != null) ...[
          Image.asset(Assets.icon.distanceicon.path, height: 14,color: AppColors.primaryColor,),
          const SizedBox(width: 4),
          Text(
            '${widget.property.distanceKm} miles',
            style: getLightStyle(
              fontSize: AppFonts.labelSmall,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFeaturesRow() {
    return Row(
      children: [
        _buildFeature(Assets.icon.bathroomicon.path, '${widget.property.bedrooms} Bedrooms'),
        const SizedBox(width: 12),
        _buildFeature(Assets.icon.bathroomicon.path, '${widget.property.bathrooms} Bathrooms'),
        const SizedBox(width: 12),
        _buildFeature(Assets.icon.kitchanicon.path, '${widget.property.kitchens} Kitchens'),
      ],
    );
  }

  Widget _buildFeature(String iconPath, String label) {
    return Row(
      children: [
        Image.asset(iconPath, height: 14),
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

  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${widget.property.price.toStringAsFixed(0)}',
          style: getBoldStyle(
            fontSize: AppFonts.bodyMedium,
            color: AppColors.darkColor,
          ),
        ),
        Row(
          children: [
            Image.asset(Assets.icon.staricon.path, height: 13,),
            const SizedBox(width: 4),
            Text(
              '${widget.property.rate ?? 0}',
              style: getMediumStyle(
                fontSize: AppFonts.labelSmall,
                color: AppColors.darkColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}