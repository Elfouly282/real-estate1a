import 'package:real_estate_1a/features/home/domain/entities/home_response_entity.dart';

class FavoritesEntity {
  final List<PropertyEntity> properties;
  final int currentPage;
  final int lastPage;
  final int total;

  const FavoritesEntity({
    required this.properties,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  bool get hasMore => currentPage < lastPage;
}
