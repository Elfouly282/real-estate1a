import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/features/home/domain/entities/home_response_entity.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/repositories/home_repository.dart';

@injectable
class HomeDataUseCase {
  final HomeRepository repository;

  const HomeDataUseCase(this.repository);

  Future<Either<Failure, HomeResponseEntity>> invoke() => repository.getHomeData();
}
