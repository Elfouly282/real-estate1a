import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_1a/features/property_details/presentation/widgets/similar_property_card_widget.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/similar_properties_cubit.dart';
import '../cubit/similar_properties_state.dart';

class SimilarPropertiesWidget extends StatelessWidget {
  const SimilarPropertiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You Must Also Like',
            style: getBoldStyle(
              fontSize: 16,
              color: AppColors.darkColor,
            ),
          ),
          const SizedBox(height: 1),
          BlocBuilder<SimilarPropertiesCubit, SimilarPropertiesState>(
            builder: (context, state) {
              if (state is SimilarPropertiesLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primaryColor),
                );
              }
              if (state is SimilarPropertiesSuccess) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.properties.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (_, index) => SimilarPropertyCardWidget(
                    property: state.properties[index],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}