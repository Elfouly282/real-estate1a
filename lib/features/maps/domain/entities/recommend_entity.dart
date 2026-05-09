
import 'package:real_estate_1a/features/maps/domain/entities/agent_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/category_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/image_entity.dart';

class RecommendedEntity {
  final int id;
  final String title;
  final String slug;
  final String description;
  final String price;
  final String listingType;
  final String status;
  final int bedrooms;
  final int bathrooms;
  final int kitchens;
  final bool isFeatured;
  final int salesCount;
  final double latitude;
  final double longitude;
  final String address;

  // نخليهم optional Entities كمان
  final CategoryEntity? category;
  final List<ImageEntity> images;
  final AgentEntity? agent;

  const RecommendedEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    required this.listingType,
    required this.status,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchens,
    required this.isFeatured,
    required this.salesCount,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.category,
    required this.images,
    this.agent,
  });
}