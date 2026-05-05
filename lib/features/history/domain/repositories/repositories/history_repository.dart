import 'package:dartz/dartz.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/history/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<Either<Failure, HistoryEntity>> getHistory({int page = 1});

}
