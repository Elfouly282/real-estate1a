class ImageModel {
	int id;
	String? url;
	int? sortOrder;

	ImageModel({required this.id, this.url, this.sortOrder});

	factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
				id: json['id'] as int,
				url: json['url'] as String?,
				sortOrder: json['sort_order'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'url': url,
				'sort_order': sortOrder,
			};
}
