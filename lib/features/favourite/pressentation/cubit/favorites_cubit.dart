import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/features/favourite/domain/entities/favourite_entity.dart';
import '../../domain/usecases/favorites_usecases.dart';

part 'favorites_state.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase    getFavoritesUseCase;
  final AddFavoriteUseCase     addFavoriteUseCase;
  final RemoveFavoriteUseCase  removeFavoriteUseCase;

  FavoritesCubit({
    required this.getFavoritesUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
  }) : super(FavoritesInitial());

  // ── saved ids for quick lookup ─────────────────────────────────────────────
  final Set<int> _favoriteIds = {};
  bool isFavorite(int propertyId) => _favoriteIds.contains(propertyId);

  // ── Get favorites ──────────────────────────────────────────────────────────

  Future<void> getFavorites({int page = 1}) async {
    emit(FavoritesLoading());

    final result = await getFavoritesUseCase.invoke(page: page);
    result.fold(
          (failure) => emit(FavoritesError(failure.message)),
          (data) {
        // cache the ids
        _favoriteIds
          ..clear()
          ..addAll(data.properties.map((p) => p.id));
        emit(FavoritesSuccess(data));
      },
    );
  }

  // ── Toggle favorite ────────────────────────────────────────────────────────

  Future<void> toggleFavorite(int propertyId) async {
    final wasAdded = isFavorite(propertyId);

    // optimistic update
    if (wasAdded) {
      _favoriteIds.remove(propertyId);
    } else {
      _favoriteIds.add(propertyId);
    }

    final result = wasAdded
        ? await removeFavoriteUseCase.invoke(propertyId)
        : await addFavoriteUseCase.invoke(propertyId);

    result.fold(
          (failure) {
        // revert on error
        if (wasAdded) {
          _favoriteIds.add(propertyId);
        } else {
          _favoriteIds.remove(propertyId);
        }
        emit(FavoritesError(failure.message));
      },
          (_) {
        emit(FavoriteActionSuccess(
          propertyId: propertyId,
          isAdded: !wasAdded,
        ));
        // refresh list
        getFavorites();
      },
    );

    }
  }

