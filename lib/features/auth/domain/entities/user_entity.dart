class UserEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? location;
  final String? phone;
  final String? createdAt;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
     this.location,
     this.phone,
     this.createdAt}
      );
}