import 'package:flutter/material.dart';
import 'package:real_estate_1a/features/payment/presentation/screens/paymetscreen.dart';
import 'package:real_estate_1a/features/property_details/domain/entities/property_details_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant/snakbar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';

class DetailsBottomBarWidget extends StatelessWidget {

  final PropertyDetailsEntity pro;
  const DetailsBottomBarWidget({super.key,required this.pro});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // navigate to 360 view
              },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffBFF8FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),

              ),
              child: Text(
                'Explore in 360',
                style: getRegularStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: ()  {
                // print('agent phone: $agentPhone');
                // if (agentPhone != null) {
                //   final uri = Uri.parse('tel:$agentPhone');
                //   if (await canLaunchUrl(uri)) {
                //     await launchUrl(uri);
                //   }
                // } else {
                //   CustomSnackbar(
                //     AppColors.errorColor,
                //     'No phone number available',
                //     true,
                //   ).show(context);
                // }
              Navigator.of(context).pushNamed(Paymetscreen.routeName,arguments: pro);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Book a Call',
                style: getMediumStyle(
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}