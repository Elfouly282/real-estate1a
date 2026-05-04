import 'package:real_estate_1a/features/favourite/domain/entities/favourite_entity.dart';
import 'package:real_estate_1a/features/home/data/models/home_response_model.dart';

class FavoritesModel extends FavoritesEntity {
  const FavoritesModel({
    required super.properties,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    final meta = json['meta'] as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;

    return FavoritesModel(
      properties: data
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: meta['current_page'] as int,
      lastPage:    meta['last_page'] as int,
      total:       meta['total'] as int,
    );
  }
}
