import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../auth/domain/entities/user_entity.dart';

class PersonalInformationScreen extends StatelessWidget {
  final UserEntity user;

  const PersonalInformationScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_outlined,size: 18,),
        ),
        title: Text(
          'Personal Information',
          style: getRegularStyle(
            fontSize: 16,
            color: AppColors.darkColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoItem(
              icon: Assets.icon.user1.path,
              title: 'Name',
              value: user.name,
            ),
            const Divider(),
            _buildInfoItem(
              icon:  Assets.icon.mail.path,
              title: 'Email',
              value: user.email,
            ),
            const Divider(),
            _buildInfoItem(
              icon:  Assets.icon.phone.path,
              title: 'Phone',
              value: user.phone ?? 'Not provided',
            ),
            const Divider(),
            _buildInfoItem(
              icon:  Assets.icon.location1.path,
              title: 'Location',
              value: user.location ?? 'Not provided',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required String icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
         Image.asset(icon,height: 23,color: AppColors.primaryColor,),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: getLightStyle(
                  fontSize: 14,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: getMediumStyle(
                  fontSize: 15,
                  color: AppColors.darkColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}