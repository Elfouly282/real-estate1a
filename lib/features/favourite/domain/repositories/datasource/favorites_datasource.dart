import 'package:dartz/dartz.dart';
import 'package:real_estate_1a/features/favourite/domain/entities/favourite_entity.dart';
import '../../../../../core/errors/failure.dart';

abstract class FavoritesDatasource {
  Future<Either<Failure, FavoritesEntity>> getFavorites({int page = 1});
  Future<Either<Failure, void>> addFavorite(int id);
  Future<Either<Failure, void>> removeFavorite(int propertyId);
}
