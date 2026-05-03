import 'package:dartz/dartz.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/home/domain/entities/home_response_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeResponseEntity>> getHomeData();


}