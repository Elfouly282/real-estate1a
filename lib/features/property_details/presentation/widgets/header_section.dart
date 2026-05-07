import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../gen/assets.gen.dart';
import '../../domain/entities/property_details_entity.dart';


class PropertyHeaderSection extends StatelessWidget {
  final PropertyDetailsEntity property;

  const PropertyHeaderSection({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        _buildImage(screenHeight),
        _buildTopIcons(context),
        _buildBottomInfo(),
      ],
    );
  }

  Widget _buildImage(double screenHeight) {
    return Container(
      height: screenHeight * 0.46,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        image: DecorationImage(
          image: NetworkImage(
            property.images.isNotEmpty
                ? property.images.first.url
                : '',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTopIcons(BuildContext context) {
    return Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(Assets.icon.arrowback.path, height: 40),
          ),
          Image.asset(Assets.icon.shareicon.path, height: 40),
        ],
      ),
    );
  }

  Widget _buildBottomInfo() {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property.address,
            style: getMediumStyle(fontSize: 25, color: AppColors.white),
          ),
          const SizedBox(height: 4),
          _buildInfoRow(),
        ],
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      children: [
        Flexible(child: _buildIconText(Assets.icon.locationicon.path, property.address)),
        _buildDivider(),
        _buildIconText(Assets.icon.distanceicon.path, '${property.distanceKm ?? 0} miles'),
        _buildDivider(),
        _buildIconText(Assets.icon.rateicon.path, '${property.rate ?? 0}'),
      ],
    );
  }

  Widget _buildIconText(String iconPath, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(iconPath, height: 16),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: getMediumStyle(fontSize: 12, color: AppColors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Container(height: 16, width: 1, color: AppColors.white),
    );
  }
}