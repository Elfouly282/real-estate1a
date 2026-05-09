class Usermodel {
	int id;
	String? name;
	String? email;
	String? role;
	dynamic location;
	dynamic phone;
	DateTime? createdAt;

	Usermodel({
		required this.id, 
		this.name, 
		this.email, 
		this.role, 
		this.location, 
		this.phone, 
		this.createdAt, 
	});

	factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
				id: json['id'] as int,
				name: json['name'] as String? ?? 'No Name',
				email: json['email'] as String? ?? 'No Email',
				role: json['role'] as String? ?? 'No Role',
				location: json['location'] as dynamic,
				phone: json['phone'] as dynamic,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
			);


}
