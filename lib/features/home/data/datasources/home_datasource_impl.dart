import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/api/api_manager.dart';
import 'package:real_estate_1a/core/api/dio_helper.dart';
import 'package:real_estate_1a/core/constant/app_constants.dart';
import 'package:real_estate_1a/features/home/data/models/home_response_model.dart';
import 'package:real_estate_1a/features/home/domain/entities/home_response_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/repositories/datasource/home_datasource.dart';

@Injectable(as: HomeDatasource)
class HomeRemoteDataSourceImpl implements HomeDatasource {
  final ApiManager apiManager;

  HomeRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Either<Failure, HomeResponseEntity>> getHomeData() async {
    try {
      final response = await apiManager.getData(
        url: AppConstants.RealEstatebaseUrl + AppConstants.homeEndPoint,
      );

      print("***************$response");
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        return Left(
          ServerException('Failed to load Home: ${response.statusCode}'),
        );
      }

      final data = HomeResponseModel.fromJson(response.data);
      print(data);
      return Right(data);

    } catch (e) {
      print(e);

      return Left(

        ServerException('Failed to load Home: $e'),
      );
    }
  }
}
