class ReviewEntity {
  final int id;
  final double rating;
  final String comment;
  final String createdAt;
  final ReviewUserEntity user;

  const ReviewEntity({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.user,
  });
}

class ReviewUserEntity {
  final int id;
  final String name;
  final String email;
  final String? image;
  final String? location;
  final String? phone;

  const ReviewUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.location,
    required this.phone,
  });
}