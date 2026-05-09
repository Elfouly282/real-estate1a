import '../../domain/entities/home_response_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.description,
    required super.sortOrder,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    slug: json['slug'] ?? '',
    description: json['description'] ?? '',
    sortOrder: json['sort_order'] ?? 0,
  );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "description": description,
      "sort_order": sortOrder,
    };
  }
}

// ── Image Model ──────────────────────────────────────────────────────────
class ImageModel extends ImageEntity {
  const ImageModel({
    required super.id,
    required super.url,
    required super.sortOrder,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: json['id'] ?? 0,
    url: json['url'] ?? '',
    sortOrder: json['sort_order'] ?? 0,
  );

  Map<String, dynamic> toJson() {
    return {"id": id, "url": url, "sort_order": sortOrder};
  }
}

// ── User Model ────────────────────────────────────────────────────────────────
class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.location,
    required super.phone,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    role: json['role'] ?? '',
    location: json['location'],
    phone: json['phone'],
    createdAt: json['created_at'],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "role": role,
      "location": location,
      "phone": phone,
      "created_at": createdAt,
    };
  }
}

// ── Agent Model ──────────────────────────────────────────────────────────────
class AgentModel extends AgentEntity {
  const AgentModel({
    required super.id,
    required super.title,
    required super.bio,
    super.licenseNumber,
    required super.company,
    required super.user,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];

    return AgentModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? json['name'] ?? '',
      bio: json['bio'] ?? '',
      licenseNumber: json['license_number'],
      company: json['company'] ?? '',
      user: userJson is Map<String, dynamic>
          ? UserModel.fromJson(userJson)
          : UserModel.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "bio": bio,
      "license_number": licenseNumber,
      "company": company,
      "user": (user as UserModel).toJson(),
    };
  }
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
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    slug: json['slug'] ?? '',
    description: json['description'] ?? '',
    price: json['price'] ?? '',
    listingType: json['listing_type'] ?? '',
    status: json['status'] ?? '',
    bedrooms: json['bedrooms'] ?? 0,
    bathrooms: json['bathrooms'] ?? 0,
    kitchens: json['kitchens'] ?? 0,
    isFeatured: json['is_featured'] ?? false,
    salesCount: json['sales_count'] ?? 0,
    rate: json['rate'] != null ? (json['rate'] as num).toDouble() : null,
    latitude: json['lat'] != null ? (json['lat'] as num).toDouble() : 0.0,
    longitude: json['lng'] != null ? (json['lng'] as num).toDouble() : 0.0,
    address: json['address'] ?? '',
    distanceKm: json['distance_km'] != null
        ? (json['distance_km'] as num).toDouble()
        : null,
    category: json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : CategoryModel(
            id: 0,
            name: '',
            slug: '',
            description: '',
            sortOrder: 0,
          ),
    images: json['images'] != null
        ? (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList()
        : [],
    agent: json['agent'] != null
        ? AgentModel.fromJson(json['agent'])
        : AgentModel(
            id: 0,
            title: '',
            bio: '',
            company: '',
            user: UserModel(
              id: 0,
              name: '',
              email: '',
              role: '',
              location: null,
              phone: null,
              createdAt: null,
            ),
          ),
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "slug": slug,
      "description": description,
      "price": price,
      "listing_type": listingType,
      "status": status,
      "bedrooms": bedrooms,
      "bathrooms": bathrooms,
      "kitchens": kitchens,
      "is_featured": isFeatured,
      "sales_count": salesCount,
      "rate": rate,
      "lat": latitude,
      "lng": longitude,
      "address": address,
      "distance_km": distanceKm,
      "category": (category as CategoryModel).toJson(),
      "images": images.map((e) => (e as ImageModel).toJson()).toList(),
      "agent": (agent as AgentModel).toJson(),
    };
  }
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
    final data = json['data'] as Map<String, dynamic>?;

    if (data == null) {
      return const HomeResponseModel(
        categories: [],
        bestSelling: [],
        featured: [],
        recommended: [],
      );
    }

    return HomeResponseModel(
      categories: data['categories'] != null
          ? (data['categories'] as List)
                .map((e) => CategoryModel.fromJson(e))
                .toList()
          : [],
      bestSelling: data['best_selling'] != null
          ? (data['best_selling'] as List)
                .map((e) => PropertyModel.fromJson(e))
                .toList()
          : [],
      featured: data['featured'] != null
          ? (data['featured'] as List)
                .map((e) => PropertyModel.fromJson(e))
                .toList()
          : [],
      recommended: data['recommended'] != null
          ? (data['recommended'] as List)
                .map((e) => PropertyModel.fromJson(e))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "categories": categories
            .map((e) => (e as CategoryModel).toJson())
            .toList(),
        "best_selling": bestSelling
            .map((e) => (e as PropertyModel).toJson())
            .toList(),
        "featured": featured.map((e) => (e as PropertyModel).toJson()).toList(),
        "recommended": recommended
            .map((e) => (e as PropertyModel).toJson())
            .toList(),
      },
    };
  }
}
