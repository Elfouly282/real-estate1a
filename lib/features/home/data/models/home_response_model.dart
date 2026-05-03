import '../../domain/entities/home_response_entity.dart';
// ── Category Model ────────────────────────────────────────────────────────────

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.description,
    required super.sortOrder,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id:          json['id'] as int,
    name:        json['name'] as String,
    slug:        json['slug'] as String,
    description: json['description'] as String,
    sortOrder:   json['sort_order'] as int,
  );
}

// ── Image Model ───────────────────────────────────────────────────────────────

class ImageModel extends ImageEntity {
  const ImageModel({
    required super.id,
    required super.url,
    required super.sortOrder,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id:        json['id'] as int,
    url:       json['url'] as String,
    sortOrder: json['sort_order'] as int,
  );
}

// ── User Model ────────────────────────────────────────────────────────────────

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id:    json['id'] as int,
    name:  json['name'] as String,
    email: json['email'] as String,
    role:  json['role'] as String,
  );
}

// ── Agent Model ───────────────────────────────────────────────────────────────

class AgentModel extends AgentEntity {
  const AgentModel({
    required super.id,
    required super.title,
    required super.bio,
    super.licenseNumber,
    required super.company,
    required super.user,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
    id:            json['id'] as int,
    title:         json['title'] as String? ?? '',
    bio:           json['bio'] as String? ?? '',
    licenseNumber: json['license_number'] as String?,
    company:       json['company'] as String? ?? '',
    user: UserModel.fromJson(
        json['user'] as Map<String, dynamic>),
  );
}

// ── Property Model ────────────────────────────────────────────────────────────

class PropertyModel extends PropertyEntity {
  const PropertyModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.description,
    required super.price,
    required super.listingType,
    required super.status,
    required super.bedrooms,
    required super.bathrooms,
    required super.kitchens,
    required super.isFeatured,
    required super.salesCount,
    super.rate,
    required super.latitude,
    required super.longitude,
    required super.address,
    super.distanceKm,
    required super.category,
    required super.images,
    required super.agent,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
    id:          json['id'] as int,
    title:       json['title'] as String,
    slug:        json['slug'] as String,
    description: json['description'] as String? ?? '',
    price:       json['price'] as String,
    listingType: json['listing_type'] as String,
    status:      json['status'] as String,
    bedrooms:    json['bedrooms'] as int? ?? 0,
    bathrooms:   json['bathrooms'] as int? ?? 0,
    kitchens:    json['kitchens'] as int? ?? 0,
    isFeatured:  json['is_featured'] as bool? ?? false,
    salesCount:  json['sales_count'] as int? ?? 0,
    rate: json['rate'] != null
        ? (json['rate'] as num).toDouble()
        : null,
    latitude:  (json['lat'] as num).toDouble(),  // ← lat بدل latitude
    longitude: (json['lng'] as num).toDouble(),  // ← lng بدل longitude
    address:   json['address'] as String? ?? '',
    distanceKm: json['distance_km'] != null
        ? (json['distance_km'] as num).toDouble()
        : null,
    category: CategoryModel.fromJson(
        json['category'] as Map<String, dynamic>),
    images: (json['images'] as List<dynamic>)
        .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    agent: AgentModel.fromJson(
        json['agent'] as Map<String, dynamic>),
  );
}

// ── Home Response Model ───────────────────────────────────────────────────────

class HomeResponseModel extends HomeResponseEntity {
  const HomeResponseModel({
    required super.categories,
    required super.bestSelling,
    required super.featured,
    required super.recommended,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return HomeResponseModel(
      categories: (data['categories'] as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bestSelling: (data['best_selling'] as List)
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      featured: (data['featured'] as List)
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommended: (data['recommended'] as List)
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}