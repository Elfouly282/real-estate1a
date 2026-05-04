import 'package:dartz/dartz.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/favourite/domain/entities/favourite_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, FavoritesEntity>> getFavorites({int page = 1});
  Future<Either<Failure, void>> addFavorite(int id);
  Future<Either<Failure, void>> removeFavorite(int propertyId);
}
