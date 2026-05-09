import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/maps/domain/entities/marker_entity.dart';
import 'package:real_estate_1a/features/maps/domain/repo/home_repository.dart';
@lazySingleton
class GetMarkerUsecase {
  HomeRepository repository;
  GetMarkerUsecase(this.repository);

  Future<Either<Failure, List<MarkerEntity>>> call() {
    
    return repository.getMarkersFromHomeData();
  }
}
