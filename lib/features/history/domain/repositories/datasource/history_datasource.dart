import 'package:dartz/dartz.dart';
import 'package:real_estate_1a/features/favourite/domain/entities/favourite_entity.dart';
import 'package:real_estate_1a/features/history/domain/entities/history_entity.dart';
import '../../../../../core/errors/failure.dart';

abstract class HistoryDatasource {
  Future<Either<Failure, HistoryEntity>> getHistory({int page = 1});

}
