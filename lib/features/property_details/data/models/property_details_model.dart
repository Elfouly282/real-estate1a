import '../../domain/entities/property_details_entity.dart';

class PropertyDetailsModel extends PropertyDetailsEntity {
  const PropertyDetailsModel({
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
    required super.rate,
    required super.latitude,
    required super.longitude,
    required super.address,
    required super.distanceKm,
    required super.category,
    required super.images,
    required super.agent,
  });

  factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return PropertyDetailsModel(
      id: data['id'] as int,
      title: data['title'] as String,
      slug: data['slug'] as String,
      description: data['description'] as String,
      price: double.parse(data['price'] as String),
      listingType: data['listing_type'] as String,
      status: data['status'] as String,
      bedrooms: data['bedrooms'] as int,
      bathrooms: data['bathrooms'] as int,
      kitchens: data['kitchens'] as int,
      isFeatured: data['is_featured'] as bool,
      salesCount: data['sales_count'] as int,
      rate: data['rate'] != null ? (data['rate'] as num).toDouble() : null,
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
      address: data['address'] as String,
      distanceKm: data['distance_km'] != null
          ? (data['distance_km'] as num).toDouble()
          : null,
      category: CategoryModel.fromJson(data['category'] as Map<String, dynamic>),
      images: (data['images'] as List)
          .map((e) => PropertyImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      agent: data['agent'] != null
     ? AgentModel.fromJson(data['agent'] as Map<String, dynamic>)
          :null,
    );
  }


  // في property_details_model.dart ضيف factory جديد
  factory PropertyDetailsModel.fromJsonList(Map<String, dynamic> json) {
    return PropertyDetailsModel(
      id: json['id'] as int,
      title: json['title'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      price: double.parse(json['price'] as String),
      listingType: json['listing_type'] as String,
      status: json['status'] as String,
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      kitchens: json['kitchens'] as int,
      isFeatured: json['is_featured'] as bool,
      salesCount: json['sales_count'] as int,
      rate: json['rate'] != null ? (json['rate'] as num).toDouble() : null,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      distanceKm: json['distance_km'] != null
          ? (json['distance_km'] as num).toDouble()
          : null,
      category: CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      images: (json['images'] as List)
          .map((e) => PropertyImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      agent: json['agent'] != null
          ? AgentModel.fromJson(json['agent'] as Map<String, dynamic>)
          : null,    );
  }
}

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.description,
    required super.sortOrder,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      sortOrder: json['sort_order'] as int,
    );
  }
}

class PropertyImageModel extends PropertyImageEntity {
  const PropertyImageModel({
    required super.id,
    required super.url,
    required super.sortOrder,
  });

  factory PropertyImageModel.fromJson(Map<String, dynamic> json) {
    return PropertyImageModel(
      id: json['id'] as int,
      url: json['url'] as String,
      sortOrder: json['sort_order'] as int,
    );
  }
}

class AgentModel extends AgentEntity {
  const AgentModel({
    required super.id,
    required super.title,
    required super.bio,
    required super.licenseNumber,
    required super.company,
    required super.user,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    return AgentModel(
      id: json['id'] as int,
      title: json['title'] as String,
      bio: json['bio'] as String,
      licenseNumber: json['license_number'] as String?,
      company: json['company'] as String,
      user: AgentUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class AgentUserModel extends AgentUserEntity {
  const AgentUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.location,
    required super.phone,
  });

  factory AgentUserModel.fromJson(Map<String, dynamic> json) {
    return AgentUserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      location: json['location'] as String?,
      phone: json['phone'] as String?,
    );
  }
}