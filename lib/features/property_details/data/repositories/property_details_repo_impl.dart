import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/dio_helper.dart';
import '../../../../core/constant/app_constants.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/property_details_entity.dart';
import '../../domain/repos/property_details_repo.dart';
import '../models/property_details_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DetailsRepo)
class DetailsRepoImpl implements DetailsRepo {
  @override
  Future<Either<Failure, PropertyDetailsEntity>> getPropertyDetails({
    required int propertyId,
  }) async {
    try {
      final response = await DioHelper.getData(
        url: '${AppConstants.propertyDetails}$propertyId',
        withAuth: true,
      );

      final property = PropertyDetailsModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      return Right(property);
    } on DioException catch (e) {
      final message = e.response?.data?['message'] as String? ??
          AppConstants.networkErrorMessage;
      return Left(ApiFailure(message: message));
    } catch (e) {
      return Left(ApiFailure(message: AppConstants.unknownErrorMessage));
    }
  }
}