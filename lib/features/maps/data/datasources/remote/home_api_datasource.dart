import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:real_estate_1a/core/api/api_manager.dart';
import 'package:real_estate_1a/core/constant/app_constants.dart';
import 'package:real_estate_1a/features/maps/data/datasources/mappers/home_mappers.dart';
import 'package:real_estate_1a/features/maps/data/datasources/remote/home_datasource.dart';
import 'package:real_estate_1a/features/maps/data/models/homeresponse.dart';
import 'package:real_estate_1a/features/maps/domain/entities/marker_entity.dart';

@LazySingleton(as: HomeDatasource)
class HomeApiDatasource implements HomeDatasource {
  final ApiManager apiManager;
  HomeApiDatasource(this.apiManager);
 
  Future<List<MarkerEntity>> getHomeDataFromCache() async {
    final response = await apiManager.getData(url: AppConstants.RealEstatebaseUrl + AppConstants.homeEndPoint );
    try {
      final result = Homeresponse.fromJson(response.data);
      if (result.data == null || result.data!.featured == null) {
        throw  ("No data from API");
      }
      return result.data!.featured!.map((e) => e.toMarkerEntity()).toList();
    } catch (e, stack) {
      if (e is DioException) {
        print('📌 $stack');
        throw Exception(e);
      }
      print('📌 $stack');
      throw Exception("Failed to load location data");
    }
  }
}
