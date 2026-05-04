part of 'favorites_cubit.dart';

abstract class FavoritesState {}

class FavoritesInitial  extends FavoritesState {}
class FavoritesLoading  extends FavoritesState {}

class FavoritesSuccess extends FavoritesState {
  final FavoritesEntity data;
  FavoritesSuccess(this.data);
}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}

class FavoriteActionLoading extends FavoritesState {}

class FavoriteActionSuccess extends FavoritesState {
  final int propertyId;
  final bool isAdded; // true = added, false = removed
  FavoriteActionSuccess({required this.propertyId, required this.isAdded});
}
class FavoriteActionFailed extends FavoritesState {
  final String message;

  FavoriteActionFailed(this.message);
}