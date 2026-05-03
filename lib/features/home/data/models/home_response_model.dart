import '../../domain/entities/home_response_entity.dart';

class HomeResponseModel extends HomeResponseEntity {
  HomeResponseModel({
    required super.categories,
    required super.bestSelling,
    required super.featured,
    required super.recommended,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return HomeResponseModel(
      categories: (data['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),

      bestSelling: (data['best_selling'] as List)
          .map((e) => PropertyModel.fromJson(e))
          .toList(),

      featured: (data['featured'] as List)
          .map((e) => PropertyModel.fromJson(e))
          .toList(),

      recommended: (data['recommended'] as List)
          .map((e) => PropertyModel.fromJson(e))
          .toList(),
    );
  }
}
class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
    );
  }
}
class PropertyModel extends PropertyEntity {
  PropertyModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.description,
    required super.price,
    required super.listingType,
    required super.bedrooms,
    required super.bathrooms,
    required super.kitchens,
    required super.isFeatured,
    required super.latitude,
    required super.longitude,
    required super.address,
    required super.images,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      price: json['price'],
      listingType: json['listing_type'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      kitchens: json['kitchens'],
      isFeatured: json['is_featured'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'],
      images: (json['images'] as List)
          .map((e) => ImageModel.fromJson(e))
          .toList(),
    );
  }
}
class ImageModel extends ImageEntity {
  ImageModel({
    required super.id,
    required super.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['url'],
    );
  }
}