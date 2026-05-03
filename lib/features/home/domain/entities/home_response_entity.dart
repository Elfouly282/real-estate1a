// ── Category Entity ───────────────────────────────────────────────────────────

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

// ── Image Entity ──────────────────────────────────────────────────────────────

class ImageEntity {
  final int id;
  final String url;
  final int sortOrder;

  const ImageEntity({
    required this.id,
    required this.url,
    required this.sortOrder,
  });
}

// ── User Entity ───────────────────────────────────────────────────────────────

class UserEntity {
  final int id;
  final String name;
  final String email;
  final String role;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

// ── Agent Entity ──────────────────────────────────────────────────────────────

class AgentEntity {
  final int id;
  final String title;
  final String bio;
  final String? licenseNumber;
  final String company;
  final UserEntity user;

  const AgentEntity({
    required this.id,
    required this.title,
    required this.bio,
    this.licenseNumber,
    required this.company,
    required this.user,
  });
}

// ── Property Entity ───────────────────────────────────────────────────────────

class PropertyEntity {
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
  final double? rate;           // ← nullable (بعض الـ properties مفيهاش rate)
  final double latitude;
  final double longitude;
  final String address;
  final double? distanceKm;     // ← nullable (بيتحسب بالـ GPS)
  final CategoryEntity category;
  final List<ImageEntity> images;
  final AgentEntity agent;

  const PropertyEntity({
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
    this.rate,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.distanceKm,
    required this.category,
    required this.images,
    required this.agent,
  });

  // ── Helpers ────────────────────────────────────────────────────────────────

  bool get isRent => listingType == 'rent';

  String get tagLabel => isRent ? 'For a Rent' : 'For Sale';

  String? get firstImageUrl => images.isNotEmpty ? images.first.url : null;

  String get formattedPrice {
    final amount = double.tryParse(price) ?? 0;
    if (isRent) return '\$${amount.toStringAsFixed(0)}/month';
    if (amount >= 1000000) return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '\$${(amount / 1000).toStringAsFixed(0)}K';
    return '\$${amount.toStringAsFixed(0)}';
  }

  String get formattedDistance => distanceKm != null
      ? '${distanceKm!.toStringAsFixed(1)} km'
      : '';

  String get formattedRate => rate != null
      ? rate!.toStringAsFixed(1)
      : '—';
}

// ── Home Response Entity ──────────────────────────────────────────────────────

class HomeResponseEntity {
  final List<CategoryEntity> categories;
  final List<PropertyEntity> bestSelling;
  final List<PropertyEntity> featured;
  final List<PropertyEntity> recommended;

  const HomeResponseEntity({
    required this.categories,
    required this.bestSelling,
    required this.featured,
    required this.recommended,
  });
}