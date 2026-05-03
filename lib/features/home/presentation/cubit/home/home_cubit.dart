import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/home_response_entity.dart';
import '../../../domain/usecases/home_usecase.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeDataUseCase getHomeDataUseCase;

  HomeCubit({required this.getHomeDataUseCase}) : super(HomeInitial());

  int _selectedFilterIndex = 0;
  int get selectedFilterIndex => _selectedFilterIndex;

  // ── Original lists ────────────────────────────────────────────────────────
  List<PropertyEntity> _allBestSelling = [];
  List<PropertyEntity> _allNearToYou   = [];

  // ── Load data ─────────────────────────────────────────────────────────────

  Future<void> getHomeData() async {
    emit(HomeLoading());

    final result = await getHomeDataUseCase.invoke();
    result.fold(
          (failure) => emit(HomeError(failure.message)),
          (data) {
        _allBestSelling = data.bestSelling;
        _allNearToYou   = data.recommended;
        emit(HomeSuccess(data));
      },
    );
  }

  // ── Filter by category ────────────────────────────────────────────────────

  void changeFilter(int index) {
    _selectedFilterIndex = index;
    final current = state;
    if (current is! HomeSuccess) return;

    // index 0 = 'All' → باقي الـ indexes = categories
    final isAll = index == 0;

    // جيب اسم الـ category المختارة
    final selectedCategory = isAll
        ? null
        : current.data.categories[index - 1].name; // ← -1 عشان 'All' في index 0

    final filteredBestSelling = isAll
        ? _allBestSelling
        : _allBestSelling
        .where((p) => p.category.name == selectedCategory)
        .toList();

    final filteredRecommended = isAll
        ? _allNearToYou
        : _allNearToYou
        .where((p) => p.category.name == selectedCategory)
        .toList();

    emit(HomeSuccess(
      HomeResponseEntity(
        categories:  current.data.categories,
        bestSelling: filteredBestSelling,
        featured:    current.data.featured,
        recommended: filteredRecommended,
      ),
    ));
  }

  // ── Sort recommended by nearest ───────────────────────────────────────────

  void sortNearby({
    required double userLat,
    required double userLng,
  }) {
    final current = state;
    if (current is! HomeSuccess) return;

    final sorted = [..._allNearToYou]..sort((a, b) {
      final distA = _calculateDistance(
          userLat, userLng, a.latitude, a.longitude);
      final distB = _calculateDistance(
          userLat, userLng, b.latitude, b.longitude);
      return distA.compareTo(distB);
    });

    emit(HomeSuccess(
      HomeResponseEntity(
        categories:  current.data.categories,
        bestSelling: current.data.bestSelling,
        featured:    current.data.featured,
        recommended: sorted,
      ),
    ));
  }

  // ── Haversine formula ─────────────────────────────────────────────────────

  double _calculateDistance(
      double lat1, double lng1,
      double lat2, double lng2,
      ) {
    const earthRadius = 6371.0;
    final dLat = _degToRad(lat2 - lat1);
    final dLng = _degToRad(lng2 - lng1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    return earthRadius * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  double _degToRad(double deg) => deg * (pi / 180);



  //search functions
// في home_cubit.dart أضف

  String _searchQuery = '';

  void searchProperties(String query) {
    _searchQuery = query.trim().toLowerCase();
    final current = state;
    if (current is! HomeSuccess) return;

    final filtered = _allBestSelling.where((p) {
      return p.title.toLowerCase().contains(_searchQuery) ||
          p.address.toLowerCase().contains(_searchQuery) ||
          p.category.name.toLowerCase().contains(_searchQuery);
    }).toList();
    final filteredNearest = _allNearToYou.where((p) {
      return p.title.toLowerCase().contains(_searchQuery) ||
          p.address.toLowerCase().contains(_searchQuery) ||
          p.category.name.toLowerCase().contains(_searchQuery);
    }).toList();
    emit(HomeSuccess(
      HomeResponseEntity(
        categories:  current.data.categories,
        bestSelling: filtered,
        featured:    current.data.featured,
        recommended: filteredNearest,
      ),
    ));
  }

  void clearSearch() {
    _searchQuery = '';
    final current = state;
    if (current is! HomeSuccess) return;
    emit(HomeSuccess(HomeResponseEntity(
      categories:  current.data.categories,
      bestSelling: _allBestSelling,
      featured:    current.data.featured,
      recommended: _allNearToYou,
    )));
  }
}