class HomeResponseEntity {
  final List<CategoryEntity> categories;
  final List<PropertyEntity> bestSelling;
  final List<PropertyEntity> featured;
  final List<PropertyEntity> recommended;

  HomeResponseEntity({
    required this.categories,
    required this.bestSelling,
    required this.featured,
    required this.recommended,
  });
}
class CategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String description;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
  });
}
class PropertyEntity {
  final int id;
  final String title;
  final String slug;
  final String description;
  final String price;
  final String listingType;
  final int bedrooms;
  final int bathrooms;
  final int kitchens;
  final bool isFeatured;
  final double latitude;
  final double longitude;
  final String address;
  final List<ImageEntity> images;

  PropertyEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    required this.listingType,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchens,
    required this.isFeatured,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.images,
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
}
class ImageEntity {
  final int id;
  final String url;

  ImageEntity({
    required this.id,
    required this.url,
  });
}