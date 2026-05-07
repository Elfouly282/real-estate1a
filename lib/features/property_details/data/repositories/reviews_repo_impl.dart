import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/dio_helper.dart';
import '../../../../core/constant/app_constants.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repos/reviews_repo.dart';
import '../models/review_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ReviewsRepo)
class ReviewsRepoImpl implements ReviewsRepo {
  @override
  Future<Either<Failure, List<ReviewEntity>>> getPropertyReviews({
    required int propertyId,
    int page = 1,
  }) async {
    try {
      final response = await DioHelper.getData(
        url: '${AppConstants.propertyReviews}$propertyId/reviews',
        query: {'page': page},
        withAuth: true,
      );

      final data = response.data['data'] as List;
      final reviews = data
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(reviews);
    } on DioException catch (e) {
      final message = e.response?.data?['message'] as String? ??
          AppConstants.networkErrorMessage;
      return Left(ApiFailure(message: message));
    } catch (e) {
      return Left(ApiFailure(message: AppConstants.unknownErrorMessage));
    }
  }
}