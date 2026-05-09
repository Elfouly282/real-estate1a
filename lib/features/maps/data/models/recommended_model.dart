import 'agent_model.dart';
import 'category_model.dart';
import 'image_model.dart';

class Recommended {
	int id;
	String? title;
	String slug;
	String? description;
	String? price;
	String? listingType;
	String? status;
	int? bedrooms;
	int? bathrooms;
	int? kitchens;
	bool? isFeatured;
	int? salesCount;
	double? latitude;
	double? longitude;
	String? address;
	CategoryModel? category;
	List<ImageModel>? images;
	AgentModel? agent;

	Recommended({
		required this.id, 
		this.title, 
		required this.slug, 
		this.description, 
		this.price, 
		this.listingType, 
		this.status, 
		this.bedrooms, 
		this.bathrooms, 
		this.kitchens, 
		this.isFeatured, 
		this.salesCount, 
		this.latitude, 
		this.longitude, 
		this.address, 
		this.category, 
		this.images, 
		this.agent, 
	});

	factory Recommended.fromJson(Map<String, dynamic> json) => Recommended(
				id: json['id'] as int,
				title: json['title'] as String?,
				slug: json['slug'] as String,
				description: json['description'] as String?,
				price: json['price'] as String?,
				listingType: json['listing_type'] as String?,
				status: json['status'] as String?,
				bedrooms: json['bedrooms'] as int?,
				bathrooms: json['bathrooms'] as int?,
				kitchens: json['kitchens'] as int?,
				isFeatured: json['is_featured'] as bool?,
				salesCount: json['sales_count'] as int?,
				latitude: (json['latitude'] as num?)?.toDouble(),
				longitude: (json['longitude'] as num?)?.toDouble(),
				address: json['address'] as String?,
				category: json['category'] == null
						? null
						: CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
				images: (json['images'] as List<dynamic>?)
						?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
						.toList(),
				agent: json['agent'] == null
						? null
						: AgentModel.fromJson(json['agent'] as Map<String, dynamic>),
			);

}
