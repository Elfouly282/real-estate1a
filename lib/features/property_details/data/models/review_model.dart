import '../../domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.rating,
    required super.comment,
    required super.createdAt,
    required super.user,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String? ?? '',
      createdAt: json['created_at'] as String,
      user: ReviewUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class ReviewUserModel extends ReviewUserEntity {
  const ReviewUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.image,
    required super.location,
    required super.phone,
  });

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) {
    return ReviewUserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      location: json['location'] as String?,
      phone: json['phone'] as String?,
    );
  }
}