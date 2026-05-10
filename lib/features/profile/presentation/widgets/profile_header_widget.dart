import 'package:flutter/material.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/core/utils/app_styles.dart';
import 'package:real_estate_1a/features/auth/domain/entities/user_entity.dart';

import '../../../../gen/assets.gen.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final UserEntity user;
  const ProfileHeaderWidget({
    super.key,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildCoverImage(),
        Positioned(
          bottom: -40,
            left: 16,
            child:
            _buildAvatar()
        ),

        // Positioned(
        //     bottom: -50,
        //     right: 16,
        //     child:
        //     _buildEditIcon()
        // ),
      ],
    );
  }


  Widget  _buildCoverImage(){
    return Container(
      height: 160,
      width: double.infinity,
      color: AppColors.primaryColor,
    );

  }

  Widget _buildAvatar(){
    return CircleAvatar(
      radius: 45,
      backgroundColor: AppColors.white,
      child: CircleAvatar(
        radius: 45,
        backgroundColor: AppColors.grey,
        child: Text(
            user.name[0].toUpperCase(),
          style: getBoldStyle(
              fontSize: 32,
              color: AppColors.primaryColor),
        ),
      ),
    );
  }

  Widget _buildEditIcon(){
    return GestureDetector(
      onTap: (){

      },
      child: Assets.icon.editicon.image(height: 20),
    );
  }
}



