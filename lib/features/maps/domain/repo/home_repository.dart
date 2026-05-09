
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/maps/domain/entities/marker_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<MarkerEntity>>> getMarkersFromHomeData();

}