import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_manager.dart';
import '../../../../core/constant/app_constants.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/datasource/history_datasource.dart';
import '../models/history_model.dart';

@Injectable(as: HistoryDatasource)
class HistoryRemoteDatasource implements HistoryDatasource {
  final ApiManager apiManager;
  const HistoryRemoteDatasource(this.apiManager);

  static final _baseUrl = AppConstants.RealEstatebaseUrl;

  @override
  Future<Either<Failure, HistoryModel>> getHistory({int page = 1}) async {
    try {
      final response = await apiManager.getData(
        url: '$_baseUrl${AppConstants.historyEndPoint}',
        query: {'page': page.toString()},
      );

      final status = response.statusCode ?? 0;

      if (status >= 200 && status < 300) {
        return Right(HistoryModel.fromJson(response.data));
      }

      return Left(ServerException('Failed: $status'));
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}