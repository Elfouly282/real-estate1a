import 'best_selling_model.dart';
import 'category_model.dart';
import 'featured_model.dart';
import 'recommended_model.dart';

class DataModel {
	List<CategoryModel>? categories;
	List<BestSelling>? bestSelling;
	List<FeaturedModel>? featured;
	List<Recommended>? recommended;

	DataModel({
		this.categories, 
		this.bestSelling, 
		this.featured, 
		this.recommended, 
	});

	factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
				categories: (json['categories'] as List<dynamic>?)
						?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
						.toList() ?? [],
				bestSelling: (json['best_selling'] as List<dynamic>?)
						?.map((e) => BestSelling.fromJson(e as Map<String, dynamic>))
						.toList() ?? [],
				featured: (json['featured'] as List<dynamic>?)
						?.map((e) => FeaturedModel.fromJson(e as Map<String, dynamic>))
						.toList() ?? [],
				recommended: (json['recommended'] as List<dynamic>?)
						?.map((e) => Recommended.fromJson(e as Map<String, dynamic>))
						.toList() ?? [],
			);


}
