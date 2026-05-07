


import 'package:dartz/dartz.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {

  Future<Either<Failure, UserEntity>> login
      ({required String email , required String password});

  Future<Either<Failure, UserEntity>> register
      ({required String name ,required String email ,
         required String password,required String passwordConfirm });

  Future<Either<Failure, UserEntity>> signInWithGoogle();



}