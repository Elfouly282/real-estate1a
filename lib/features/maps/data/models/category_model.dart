class CategoryModel {
	int id;
	String? name;
	String slug;
	String? description;
	int? sortOrder;

	CategoryModel({
		required this.id, 
		this.name, 
		required this.slug, 
		this.description, 
		this.sortOrder, 
	});

	factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
				id: json['id'] as int,
				name: json['name'] as String? ?? '',
				slug: json['slug'] as String ,
				description: json['description'] as String? ?? '',
				sortOrder: json['sort_order'] as int? ?? 0,
			);


}
