import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/home_response_entity.dart';
import '../widgets/nearest_property_card.dart';

class ViewAllPropertiesScreen extends StatelessWidget {
  final String title;
  final List<PropertyEntity> properties;

  const ViewAllPropertiesScreen({
    super.key,
    required this.title,
    required this.properties,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.backgroundColor,
      ),

      body: properties.isEmpty
          ? const Center(
        child: Text("No properties found"),
      )
          : ListView.separated(
        padding: EdgeInsets.all(16.w),

        itemCount: properties.length,

        separatorBuilder: (_, __) =>
            SizedBox(height: 12.h),
        itemBuilder: (_, i) {
          return NearestPropertyCard(
            property: properties[i],
          );
        },
      ),
    );
  }
}