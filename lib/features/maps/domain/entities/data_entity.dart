
import 'package:real_estate_1a/features/maps/domain/entities/bestsalling_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/category_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/feature_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/recommend_entity.dart';

class DataEntity {
 final List<CategoryEntity>? categories;
  final List<BestSellingEntity>? bestSelling;
  final List<FeatureEntity >? featured;
  final List<RecommendedEntity>? recommended;
  

  DataEntity({
    this.categories,
    this.bestSelling,
    this.featured,
    this.recommended,
  });
}
