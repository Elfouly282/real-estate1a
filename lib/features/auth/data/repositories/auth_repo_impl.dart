

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/constant/app_constants.dart';
import '../../../../core/di.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/security/security_helper.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../models/user_model.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl();

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: AppConstants.login,
        data: {'email': email, 'password': password},
      );
      await getIt<AuthStorage>().setToken(response.data['data']['token']);
      return Right(UserModel.fromJson(response.data['data']['user']));
    } on ServerException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data['message'] ?? 'Something went wrong';
        return Left(ApiFailure(message: message));
      }
      return Left(ServiceFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: AppConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirm,
        },
      );
      return Right(UserModel.fromJson(response.data['data']['user']));
    } on ServerException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data['message'] ?? 'Something went wrong';
        return Left(ApiFailure(message: message));
      }
      return Left(ServiceFailure(message: e.toString()));
    }
  }



  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return Left(ServiceFailure(message: 'Cancelled'));

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseUser = userCredential.user!;

      return Right(UserEntity(
        id: int.tryParse(firebaseUser.uid) ?? 0,
        name: firebaseUser.displayName ?? '',
        email: firebaseUser.email ?? '',
        role: 'user',
      ));
    } catch (e) {
      print('❌ error: $e');
      return Left(ServiceFailure(message: e.toString()));
    }
  }
}