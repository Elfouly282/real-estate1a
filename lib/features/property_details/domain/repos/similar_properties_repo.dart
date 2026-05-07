import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/property_details_entity.dart';

abstract class SimilarPropertiesRepo {
  Future<Either<Failure, List<PropertyDetailsEntity>>> getSimilarProperties({
    required int propertyId,
  });
}