import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_1a/features/maps/data/models/agent_model.dart';
import 'package:real_estate_1a/features/maps/data/models/best_selling_model.dart';
import 'package:real_estate_1a/features/maps/data/models/category_model.dart';
import 'package:real_estate_1a/features/maps/data/models/data_model.dart';
import 'package:real_estate_1a/features/maps/data/models/featured_model.dart';
import 'package:real_estate_1a/features/maps/data/models/image_model.dart';
import 'package:real_estate_1a/features/maps/data/models/recommended_model.dart';
import 'package:real_estate_1a/features/maps/data/models/user_model.dart';
import 'package:real_estate_1a/features/maps/domain/entities/agent_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/bestsalling_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/category_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/data_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/feature_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/image_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/marker_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/recommend_entity.dart';
import 'package:real_estate_1a/features/maps/domain/entities/user_entity.dart';

extension FeaturedModelMapper on FeaturedModel {
  FeatureEntity toEntity() {
    return FeatureEntity(
      id: id,
      title: title,
      slug: slug,
      description: description,
      price: price,
      listingType: listingType,
      status: status,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      kitchens: kitchens,
      isFeatured: isFeatured,
      salesCount: salesCount,
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }

  MarkerEntity toMarkerEntity() {
    return MarkerEntity(
      id: id.toString(),
      latitude: latitude ,
      longitude: longitude ,
    );
  }
}
extension CategoryModelMapper on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      slug: slug,
      description: description,
      sortOrder: sortOrder,
    );
  }
}

extension DataModelMapper on DataModel {
  DataEntity toEntity() {
    return DataEntity(
      categories: categories?.map((e) => e.toEntity()).toList(),
      bestSelling: bestSelling?.map((e) => e.toEntity()).toList(),
      featured: featured?.map((e) => e.toEntity()).toList(),
      recommended: recommended?.map((e) => e.toEntity()).toList(),
    );
  }
}

 extension RecommendedModelMapper on Recommended {
  RecommendedEntity toEntity() {
    return RecommendedEntity(
      id: id,
      title: title ?? '',
      slug: slug,
      description: description ?? '',
      price: price ?? '',
      listingType: listingType ?? '',
      status: status ?? '',
      bedrooms: bedrooms ?? 0,
      bathrooms: bathrooms ?? 0,
      kitchens: kitchens ?? 0,
      isFeatured: isFeatured ?? false,
      salesCount: salesCount ?? 0,
      latitude: latitude ?? 0.0,
      longitude: longitude ?? 0.0,
      address: address ?? '',
      category: category?.toEntity(),
      images: images?.map((e) => e.toEntity()).toList() ?? [],
      agent: agent?.toEntity(),
    );
  }
}

extension BestSellingModelMapper on BestSelling {
  BestSellingEntity toEntity() {
    return BestSellingEntity(
      id: id,
      title: title ?? '',
      slug: slug,
      description: description ?? '',
      price: price ?? '',
      listingType: listingType ?? '',
      status: status ?? '',
      bedrooms: bedrooms ?? 0,
      bathrooms: bathrooms ?? 0,
      kitchens: kitchens ?? 0,
      isFeatured: isFeatured ?? false,
      salesCount: salesCount ?? 0,
      latitude: latitude ?? 0.0,
      longitude: longitude ?? 0.0,
      address: address ?? '',
      category: category?.toEntity(),
      images: images?.map((e) => e.toEntity()).toList() ?? [],
      agent: agent?.toEntity(),
    );
  }
}

extension ImageModelMapper on ImageModel {
  ImageEntity toEntity() {
    return ImageEntity(
      id: id,
      url: url ?? '',
    );
  }
}
extension AgentModelMapper on AgentModel {
  AgentEntity toEntity() {
    return AgentEntity(
      id: id,
      title: title,
      bio: bio,
      licenseNumber: licenseNumber,
      company: company,
   userEntity: usermodel?.toEntity(),
    );
  }
}
extension UserModelMapper on Usermodel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name ?? '',
      email: email ?? '',
      role: role ?? '',
      location: location?.toString() ?? '',
      phone: phone?.toString() ?? '',
      createdAt: createdAt,
    );
  }
}