import 'package:real_estate_1a/features/maps/data/models/user_model.dart';

class AgentModel {
  int id;
  String? title;
  String? bio;
  dynamic licenseNumber;
  String? company;
  Usermodel? usermodel;

  AgentModel({
    required this.id,
    this.title,
    this.bio,
    this.licenseNumber,
    this.company,
    this.usermodel,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
    id: json['id'] as int,
    title: json['title'] as String? ?? 'No Title',
    bio: json['bio'] as String? ?? 'No Bio available',
    licenseNumber: json['license_number'] as dynamic,
    company: json['company'] as String? ?? 'No Company Name',
    usermodel: json['user'] == null
        ? null
        : Usermodel.fromJson(json['user'] as Map<String, dynamic>),
  );
}
