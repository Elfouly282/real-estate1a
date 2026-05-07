import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/dio_helper.dart';
import '../../../../core/constant/app_constants.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/property_details_entity.dart';
import '../../domain/repos/similar_properties_repo.dart';
import '../models/property_details_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SimilarPropertiesRepo)
class SimilarPropertiesRepoImpl implements SimilarPropertiesRepo {
  @override
  Future<Either<Failure, List<PropertyDetailsEntity>>> getSimilarProperties({
    required int propertyId,
  }) async {
    try {
      final response = await DioHelper.getData(
        url: '${AppConstants.propertyDetails}$propertyId/similar',
        withAuth: true,
      );

      final data = response.data['data'] as List;
      final properties = data
          .map((e) => PropertyDetailsModel.fromJsonList(e as Map<String, dynamic>))
          .toList();

      return Right(properties);
    } on DioException catch (e) {
      final message = e.response?.data?['message'] as String? ??
          AppConstants.networkErrorMessage;
      return Left(ApiFailure(message: message));
    } catch (e) {
      return Left(ApiFailure(message: AppConstants.unknownErrorMessage));
    }
  }
}