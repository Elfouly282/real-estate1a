import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_1a/features/property_details/presentation/cubit/property_details_state.dart';

import '../../domain/repos/property_details_repo.dart';

@injectable
class DetailsCubit extends Cubit<DetailsState> {
  final DetailsRepo repo;

  DetailsCubit({required this.repo}) : super(DetailsInitial());

  Future<void> getPropertyDetails({required int propertyId}) async {
    emit(DetailsLoading());

    final result = await repo.getPropertyDetails(propertyId: propertyId);

    result.fold(
          (failure) => emit(DetailsFailure(message: failure.message)),
          (property) => emit(DetailsSuccess(property: property)),
    );
  }
}