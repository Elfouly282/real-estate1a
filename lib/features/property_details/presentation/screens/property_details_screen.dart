import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';

import '../../../../core/constant/snakbar.dart';
import '../../../../core/di.dart';
import '../../domain/repos/property_details_repo.dart';
import '../../domain/repos/similar_properties_repo.dart';
import '../cubit/property_details_cubit.dart';
import '../cubit/property_details_state.dart';
import '../cubit/similar_properties_cubit.dart';
import '../widgets/details_bottom_bar_widget.dart';
import '../widgets/header_section.dart';
import '../widgets/listing_agent_widget.dart';
import '../widgets/location_map_widget.dart';
import '../widgets/property_description_wdget.dart';
import '../widgets/property_info_widget.dart';
import '../widgets/similar_properties_widget.dart';
import '../widgets/user_reviews_section_widget.dart';


class PropertyDetailsScreen extends StatelessWidget {
  static String routeName="propertyDetails";
  final int propertyId;

  const PropertyDetailsScreen({
    super.key,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DetailsCubit(repo: getIt<DetailsRepo>())
            ..getPropertyDetails(propertyId: propertyId),
        ),
        BlocProvider(
          create: (_) => SimilarPropertiesCubit(repo: getIt<SimilarPropertiesRepo>())
            ..getSimilarProperties(propertyId: propertyId),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        bottomNavigationBar: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            if (state is DetailsSuccess) {
              return DetailsBottomBarWidget(
                agentPhone: state.property.agent?.user.phone,
              );
            }
            return const SizedBox();
          },
        ),
        body: BlocConsumer<DetailsCubit, DetailsState>(
          listener: (context, state) {
            if (state is DetailsFailure) {
              CustomSnackbar(
                AppColors.errorColor,
                state.message,
                true,
              ).show(context);
            }
          },
          builder: (context, state) {
            if (state is DetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }
            if (state is DetailsSuccess) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  PropertyHeaderSection(property: state.property),
                  const SizedBox(height: 16),
                  PropertyInfoWidget(property: state.property),
                  const SizedBox(height: 16),
                  PropertyDescriptionWidget(
                    description: state.property.description,
                  ),
                  const SizedBox(height: 16),
                  if (state.property.agent != null)
                    ListingAgentWidget(agent: state.property.agent!),
                  const SizedBox(height: 20),
               PropertyLocationMap(latitude:state.property.latitude ,longitude:state.property.longitude) ,
                  const SizedBox(height: 20),
                  UserReviewsSectionWidget(
                    propertyId: state.property.id,
                    rate: state.property.rate,
                    propertyImages: state.property.images,
                  ),
                  SimilarPropertiesWidget(),
                  const SizedBox(height: 100),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}