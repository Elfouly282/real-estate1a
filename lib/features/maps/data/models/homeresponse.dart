import 'data_model.dart';

class Homeresponse {
	DataModel? data;

	Homeresponse({this.data});

	factory Homeresponse.fromJson(Map<String, dynamic> json) => Homeresponse(
				data: json['data'] == null
						? null
						: DataModel.fromJson(json['data'] as Map<String, dynamic>),
			);


}
