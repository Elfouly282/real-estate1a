import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_manager.dart';
import '../../../../core/constant/app_constants.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/datasource/favorites_datasource.dart';
import '../models/favorites_model.dart';

@Injectable(as: FavoritesDatasource)
class FavoritesRemoteDatasource implements FavoritesDatasource {
  final ApiManager apiManager;
  const FavoritesRemoteDatasource(this.apiManager);

  static final _baseUrl = AppConstants.RealEstatebaseUrl;

  @override
  Future<Either<Failure, FavoritesModel>> getFavorites({int page = 1}) async {
    try {
      final response = await apiManager.getData(
        url: '$_baseUrl${AppConstants.getFavorite}',
        query: {'page': page.toString()},
      );

      final status = response.statusCode ?? 0;

      if (status >= 200 && status < 300) {
        return Right(FavoritesModel.fromJson(response.data));
      }

      return Left(ServerException('Failed: $status'));
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addFavorite(int id) async {
    try {
      final response = await apiManager.post(
        url: '$_baseUrl${AppConstants.getFavorite}',
        data: {'property_id': id},
      );

      final status = response.statusCode ?? 0;

      if (status >= 200 && status < 300) {
        return const Right(unit);
      }

      return Left(ServerException('Failed: $status'));
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFavorite(int propertyId) async {
    try {
      final response = await apiManager.delete(
        url: 'https://real.newcinderella.online/api/v1/favorites/$propertyId',
      );

      final status = response.statusCode ?? 0;

      if (status >= 200 && status < 300) {
        return const Right(unit);
      }
      print(status);

      return Left(ServerException('Failed: $status'));
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }}