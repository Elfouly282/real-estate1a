import 'agent_model.dart';
import 'category_model.dart';
import 'image_model.dart';

class FeaturedModel {
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
	bool isFeatured;
	int? salesCount;
	double? latitude;
	double? longitude;
	String? address;
	CategoryModel? category;
	List<ImageModel>? images;
	AgentModel? agent;

	FeaturedModel({
		required this.id, 
		required this.title, 
		required this.slug, 
		this.description, 
		this.price, 
		this.listingType, 
		this.status, 
		this.bedrooms, 
		this.bathrooms, 
		this.kitchens, 
		 this.isFeatured =false, 
		this.salesCount, 
		this.latitude, 
		this.longitude, 
		this.address, 
		this.category, 
		this.images, 
		this.agent, 
	});

	factory FeaturedModel.fromJson(Map<String, dynamic> json) => FeaturedModel(
				id: json['id'] as int,
				title: json['title'] as String?,
				slug: json['slug'] as String ,
				description: json['description'] as String? ?? 'No description available',
				price: json['price'] as String? ?? 'Price not available',
				listingType: json['listing_type'] as String? ?? 'Unknown',
				status: json['status'] as String? ?? 'Unknown',
				bedrooms: json['bedrooms'] as int? ?? 0,
				bathrooms: json['bathrooms'] as int? ?? 0,
				kitchens: json['kitchens'] as int? ?? 0,
				isFeatured: json['is_featured'] as bool? ?? false,
				salesCount: json['sales_count'] as int?,
				latitude: (json['latitude'] as num?)?.toDouble(),
				longitude: (json['longitude'] as num?)?.toDouble(),
				address: json['address'] as String? ?? 'No Address',
				category: json['category'] == null
						? null
						: CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
				images: (json['images'] as List<dynamic>?)
						?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
						.toList() ?? [],
				agent: json['agent'] == null
						? null
						: AgentModel.fromJson(json['agent'] as Map<String, dynamic>),
			);


}
