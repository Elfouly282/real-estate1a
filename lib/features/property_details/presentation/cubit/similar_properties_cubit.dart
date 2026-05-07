import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repos/similar_properties_repo.dart';
import 'similar_properties_state.dart';


@injectable
class SimilarPropertiesCubit extends Cubit<SimilarPropertiesState> {
  final SimilarPropertiesRepo repo;

  SimilarPropertiesCubit({required this.repo}) : super(SimilarPropertiesInitial());

  Future<void> getSimilarProperties({required int propertyId}) async {
    emit(SimilarPropertiesLoading());

    final result = await repo.getSimilarProperties(propertyId: propertyId);

    result.fold(
          (failure) => emit(SimilarPropertiesFailure(message: failure.message)),
          (properties) => emit(SimilarPropertiesSuccess(properties: properties)),
    );
  }
}