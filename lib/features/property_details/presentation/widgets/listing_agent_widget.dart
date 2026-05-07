import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant/snakbar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entities/property_details_entity.dart';

class ListingAgentWidget extends StatelessWidget {
  final AgentEntity agent;

  const ListingAgentWidget({
    super.key,
    required this.agent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Listing Agent',
            style: getBoldStyle(
              fontSize: 16,
              color: AppColors.darkColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: 12),
              _buildAgentInfo(),
              const Spacer(),
              _buildActionIcons(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.grey,
      child: Text(
        agent.user.name[0].toUpperCase(),
        style: getBoldStyle(
          fontSize: AppFonts.titleMedium,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildAgentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          agent.user.name,
          style: getMediumStyle(
            fontSize: 14,
            color: AppColors.darkColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          agent.title,
          style: getRegularStyle(
            fontSize: 12,
            color: AppColors.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionIcons(BuildContext context) {
    return Row(
      children: [
        _buildIconButton(
          iconPath: Assets.icon.call.path,
          onTap: () async {
            if (agent.user.phone != null) {
              final uri = Uri.parse('tel:${agent.user.phone}');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            } else {
              CustomSnackbar(
                AppColors.errorColor,
                'No phone number available',
                true,
              ).show(context);
            }
          },
        ),
        const SizedBox(width: 12),

        _buildIconButton(
          iconPath: Assets.icon.message.path,
          onTap: () async {
            final uri = Uri.parse('mailto:${agent.user.email}');
            try {
              await launchUrl(uri);
            } catch (e) {
              CustomSnackbar(
                AppColors.errorColor,
                'No Email Address available',
                true,
              ).show(context);
            }
          },
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,

        ),
        child: Image.asset(iconPath, height: 28),
      ),
    );
  }
}