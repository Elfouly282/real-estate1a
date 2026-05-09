

import 'package:real_estate_1a/features/maps/domain/entities/user_entity.dart';

class AgentEntity {
  final int id;
  final String? title;
  final String? bio;
  final dynamic licenseNumber;
  final String? company;
  final UserEntity? userEntity;
 const AgentEntity({
    required this.id,
    this.title,
    this.bio,
    this.licenseNumber,
    this.company,
    this.userEntity,
  });
}
