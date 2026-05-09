class UserEntity {
	final int id;
	final String? name;
	final String? email;
	final String? role;
	final dynamic location;
	final dynamic phone;
	final DateTime? createdAt;
  const UserEntity({
    required this.id, 
    this.name, 
    this.email, 
    this.role, 
    this.location, 
    this.phone, 
    this.createdAt, 
  });
}