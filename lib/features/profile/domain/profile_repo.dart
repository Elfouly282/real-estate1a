import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../auth/domain/entities/user_entity.dart';

abstract class ProfileRepo {

  Future<Either<Failure, UserEntity>> getProfile();

  Future<Either<Failure, UserEntity>> updateProfile({
    required String name,
    String? location,
    String? phone,
});

  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, String>> deleteAccount();



}