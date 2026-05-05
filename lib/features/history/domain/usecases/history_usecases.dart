import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import '../entities/history_entity.dart';
import '../repositories/repositories/history_repository.dart';

@injectable
class GetHistoryUseCase {
  final HistoryRepository repository;
  const GetHistoryUseCase(this.repository);
  Future<Either<Failure, HistoryEntity>> invoke({int page = 1}) =>
      repository.getHistory(page: page);
}
