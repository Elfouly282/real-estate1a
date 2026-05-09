import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/api/dio_helper.dart';
import 'package:real_estate_1a/core/constant/app_constants.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/auth/data/models/user_model.dart';
import 'package:real_estate_1a/features/auth/domain/entities/user_entity.dart';
import 'package:real_estate_1a/features/profile/domain/profile_repo.dart';
import 'package:dio/dio.dart';


@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo{

///////get profile

  @override
  Future<Either<Failure, UserEntity>> getProfile() async{
    try{
      final response=await DioHelper.getData(
          url: AppConstants.getProfile,
        withAuth: true
      );
      final user = UserModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
      return Right(user);
    } on DioException catch (e) {
      final message = e.response?.data?['message'] as String? ??
          AppConstants.networkErrorMessage;
      return Left(ApiFailure(message: message));
    } catch (e) {
      return Left(ApiFailure(message: AppConstants.unknownErrorMessage));
    }
  }



//////////update profile

  @override
  Future<Either<Failure, UserEntity>> updateProfile({
    required String name, String? location, String? phone,

}) async{
    try{

      final response=await DioHelper.putDataWithAuth(
          url: AppConstants.updateProfile,

          data: {
            'name' : name,
            if (location != null) 'location': location,
            if (phone != null) 'phone': phone,
          },
          withAuth: true
      );
      final user = UserModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
      return Right(user);
    }on DioException catch(e){
      final message=e.response?.data?['message'] as String? ??
    AppConstants.networkErrorMessage;
      return Left(ApiFailure(message: message));

    }catch (e){
      return Left(ApiFailure(message: AppConstants.unknownErrorMessage));
    }


  }



  /////change password

  @override
  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await DioHelper.putDataWithAuth(
        url: AppConstants.changePassword,
        data: {
          'current_password': currentPassword,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
        withAuth: true,
      );
      return const Right('Password changed successfully');
    } on DioException catch (e) {
      final message = e.response?.data?['message'] as String? ??
          AppConstants.networkErrorMessage;
      return Left(ApiFailure(message: message));
    } catch (e) {
      return Left(ApiFailure(message: AppConstants.unknownErrorMessage));
    }
  }

  ////delete account

  @override
  Future<Either<Failure, String>> deleteAccount() async {
    try {
      await DioHelper.deleteDataWithAuth(
        url: AppConstants.deleteAccount,
        withAuth: true,
      );
      return const Right('Account deleted successfully');
    } on DioException catch (e) {
      final message = e.response?.data?['message'] as String? ??
          AppConstants.networkErrorMessage;
      return Left(ApiFailure(message: message));
    } catch (e) {
      return Left(ApiFailure(message: AppConstants.unknownErrorMessage));
    }
  }
}



