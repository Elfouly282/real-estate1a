

import 'package:real_estate_1a/features/maps/data/models/agent_model.dart';
import 'package:real_estate_1a/features/maps/data/models/category_model.dart';
import 'package:real_estate_1a/features/maps/data/models/image_model.dart';

class BestSelling {
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

	BestSelling({
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

	factory BestSelling.fromJson(Map<String, dynamic> json) => BestSelling(
				id: json['id'] as int,
				title: json['title'] as String? ?? 'No Title',
				slug: json['slug'] as String,
				description: json['description'] as String? ?? 'No Description',
				price: json['price'] as String? ?? 'No Price',
				listingType: json['listing_type'] as String? ?? 'No Listing Type',
				status: json['status'] as String? ?? 'No Status',
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
