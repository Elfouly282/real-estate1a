import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../entities/home_response_entity.dart';

abstract class HomeDatasource {
  Future<Either<Failure, HomeResponseEntity>> getHomeData();
}