import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/features/home/domain/entities/home_response_entity.dart';
import 'package:real_estate_1a/features/home/domain/repositories/datasource/home_datasource.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/repositories/repositories/home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource remoteDataSource;

  const HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, HomeResponseEntity>> getHomeData() =>
      remoteDataSource.getHomeData();
  @override
  Future<Either<Failure, List<PropertyEntity>>> getNearbyProperties({required double latitude, required double longitude, double radiusInKm = 5}) {
    // TODO: implement getNearbyProperties
    throw UnimplementedError();
  }
}
