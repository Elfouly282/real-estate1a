import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/review_entity.dart';

abstract class ReviewsRepo {
  Future<Either<Failure, List<ReviewEntity>>> getPropertyReviews({
    required int propertyId,
    int page = 1,
  });
}