import 'package:flutter/cupertino.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';

class PropertyDescriptionWidget extends StatefulWidget {
  final String description;

  const PropertyDescriptionWidget({
    super.key,
    required this.description,
  });

  @override
  State<PropertyDescriptionWidget> createState() =>
      _PropertyDescriptionWidgetState();
}

class _PropertyDescriptionWidgetState
    extends State<PropertyDescriptionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: getBoldStyle(
              fontSize: 16,
              color: AppColors.darkColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            maxLines: _isExpanded ? null : 3,
            overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: getLightStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Text(
              _isExpanded ? 'See Less' : 'See More',
              style: getMediumStyle(
                fontSize: AppFonts.bodySmall,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}