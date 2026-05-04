import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import '../entities/favourite_entity.dart';
import '../repositories/repositories/favorites_repository.dart';

@injectable
class GetFavoritesUseCase {
  final FavoritesRepository repository;
  const GetFavoritesUseCase(this.repository);
  Future<Either<Failure, FavoritesEntity>> invoke({int page = 1}) =>
      repository.getFavorites(page: page);
}
@injectable
class AddFavoriteUseCase {
  final FavoritesRepository repository;
  const AddFavoriteUseCase(this.repository);
  Future<Either<Failure, void>> invoke(int id) =>
      repository.addFavorite(id);
}
@injectable
class RemoveFavoriteUseCase {
  final FavoritesRepository repository;
  const RemoveFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> invoke(int propertyId) =>
      repository.removeFavorite(propertyId);
}