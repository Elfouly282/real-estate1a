
import 'package:real_estate_1a/features/maps/domain/entities/agent_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/image_entity.dart';

class FeatureEntity {
  final int id;
  final String? title;
  final String slug;
  final String? description;
  final String? price;
  final String? listingType;
  final String? status;
  final int? bedrooms;
  final int? bathrooms;
  final int? kitchens;
  final bool? isFeatured;
  final int? salesCount;
  final double? latitude;
  final double? longitude;
  final String? address;

  final List<ImageEntity>? images;
  final AgentEntity? agent;

 const FeatureEntity({
    required this.id,
    this.title,
    required this.slug,
    this.description,
    this.price,
    this.listingType,
    this.status,
    this.bedrooms,
    this.bathrooms,
    this.kitchens,
    this.isFeatured,
    this.salesCount,
    this.latitude,
    this.longitude,
    this.address,
    this.images,
    this.agent,
  });
}
