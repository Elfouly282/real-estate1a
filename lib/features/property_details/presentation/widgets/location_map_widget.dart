import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entities/property_details_entity.dart';

class LocationMapWidget extends StatelessWidget {
  final PropertyDetailsEntity property;

  const LocationMapWidget({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    final latLng = LatLng(property.latitude, property.longitude);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location Address',
            style: getBoldStyle(
              fontSize: AppFonts.titleSmall,
              color: AppColors.darkColor,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 180,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: latLng,
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('property'),
                    position: latLng,
                  ),
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
              ),
            ),
          ),
          const SizedBox(height: 12),
         // _buildAddressRow(),
        ],
      ),
    );
  }

  Widget _buildAddressRow() {
    return Row(
      children: [
        Image.asset(Assets.icon.locationicon.path, height: 16),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              property.title,
              style: getMediumStyle(
                fontSize: AppFonts.bodySmall,
                color: AppColors.darkColor,
              ),
            ),
            Text(
              property.address,
              style: getLightStyle(
                fontSize: AppFonts.labelSmall,
                color: AppColors.textSecondaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}