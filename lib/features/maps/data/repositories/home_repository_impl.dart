import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/maps/data/datasources/remote/home_datasource.dart';
import 'package:real_estate_1a/features/maps/domain/entities/marker_entity.dart';
import 'package:real_estate_1a/features/maps/domain/repo/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource homeDatasource;
  HomeRepositoryImpl(this.homeDatasource);
 

  @override
  Future<Either<Failure, List<MarkerEntity>>> getMarkersFromHomeData() async {
    try {
      final response = await homeDatasource.getHomeDataFromCache();
      return Right(response);
    }  catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}
