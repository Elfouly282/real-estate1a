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

  // ── Filter ────────────────────────────────────────────────────────────────
  static const filters = ['All', 'Sale', 'Rent','House','Apartment'];

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
        _allBestSelling = data.bestSelling; // ← احفظ الأصلية
        _allNearToYou   = data.recommended; // ← احفظ الأصلية
        emit(HomeSuccess(data));
      },
    );
  }

  // ── Filter by listing type ────────────────────────────────────────────────

  void changeFilter(int index) {
    _selectedFilterIndex = index;
    final current = state;
    if (current is! HomeSuccess) return;

    final filter = filters[index]; // 'All' | 'Sale' | 'Rent'

    final filteredBestSelling = filter == 'All'
        ? _allBestSelling
        : _allBestSelling
        .where((p) => p.listingType == filter.toLowerCase())
        .toList();

    final filteredRecommended = filter == 'All'
        ? _allNearToYou
        : _allNearToYou
        .where((p) => p.listingType == filter.toLowerCase())
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
}