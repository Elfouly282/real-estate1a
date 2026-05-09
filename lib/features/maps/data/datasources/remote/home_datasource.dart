
import 'package:real_estate_1a/features/maps/domain/entities/marker_entity.dart';

abstract class HomeDatasource {
 
  Future<List<MarkerEntity>> getHomeDataFromCache();
}
