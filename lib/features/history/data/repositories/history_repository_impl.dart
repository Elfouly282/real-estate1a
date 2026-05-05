import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/favourite/domain/entities/favourite_entity.dart';
import 'package:real_estate_1a/features/favourite/domain/repositories/datasource/favorites_datasource.dart';
import 'package:real_estate_1a/features/favourite/domain/repositories/repositories/favorites_repository.dart';
import 'package:real_estate_1a/features/history/domain/entities/history_entity.dart';
import 'package:real_estate_1a/features/history/domain/repositories/datasource/history_datasource.dart';
import 'package:real_estate_1a/features/history/domain/repositories/repositories/history_repository.dart';

@Injectable(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDatasource datasource;
  const HistoryRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, HistoryEntity>> getHistory({int page = 1}) =>datasource.getHistory(page:page);
}
