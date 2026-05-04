import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/favourite/domain/entities/favourite_entity.dart';
import 'package:real_estate_1a/features/favourite/domain/repositories/datasource/favorites_datasource.dart';
import 'package:real_estate_1a/features/favourite/domain/repositories/repositories/favorites_repository.dart';

@Injectable(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDatasource datasource;
  const FavoritesRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, FavoritesEntity>> getFavorites({int page = 1}) =>
      datasource.getFavorites(page: page);

  @override
  Future<Either<Failure, void>> addFavorite(int id) =>
      datasource.addFavorite(id);

  @override
  Future<Either<Failure, void>> removeFavorite(int propertyId) =>
      datasource.removeFavorite(propertyId);
}
