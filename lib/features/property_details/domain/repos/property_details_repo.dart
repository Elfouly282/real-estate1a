import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/property_details_entity.dart';

abstract class DetailsRepo {
  Future<Either<Failure, PropertyDetailsEntity>> getPropertyDetails({
    required int propertyId,
  });
}