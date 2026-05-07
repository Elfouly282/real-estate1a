class PropertyDetailsEntity {
  final int id;
  final String title;
  final String slug;
  final String description;
  final double price;
  final String listingType; // sale / rent
  final String status;
  final int bedrooms;
  final int bathrooms;
  final int kitchens;
  final bool isFeatured;
  final int salesCount;
  final double? rate;
  final double latitude;
  final double longitude;
  final String address;
  final double? distanceKm;
  final CategoryEntity category;
  final List<PropertyImageEntity> images;
  final AgentEntity? agent;

  const PropertyDetailsEntity({
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
    required this.rate,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.distanceKm,
    required this.category,
    required this.images,
    required this.agent,
  });
}

class CategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String description;
  final int sortOrder;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.sortOrder,
  });
}

class PropertyImageEntity {
  final int id;
  final String url;
  final int sortOrder;

  const PropertyImageEntity({
    required this.id,
    required this.url,
    required this.sortOrder,
  });
}

class AgentEntity {
  final int id;
  final String title;
  final String bio;
  final String? licenseNumber;
  final String company;
  final AgentUserEntity user;

  const AgentEntity({
    required this.id,
    required this.title,
    required this.bio,
    required this.licenseNumber,
    required this.company,
    required this.user,
  });
}

class AgentUserEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? location;
  final String? phone;

  const AgentUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.location,
    required this.phone,
  });
}