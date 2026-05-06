import 'package:real_estate_1a/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.location,
    super.phone,
    super.createdAt
  });

  factory UserModel.fromJson(Map<String,dynamic>json){

    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      location: json['location'],
      phone: json['phone'],
      createdAt: json['created_at'],
    );
  }

}