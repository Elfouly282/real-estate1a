

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/features/profile/presentation/cubit/profile_state.dart';

import '../../domain/profile_repo.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;

  ProfileCubit({required this.repo}) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await repo.getProfile();
    result.fold(
          (failure) => emit(ProfileFailure(message: failure.message)),
          (user) => emit(ProfileSuccess(user: user)),
    );
  }

  Future<void> updateProfile({
    required String name,
    String? location,
    String? phone,
  }) async {
    emit(ProfileLoading());
    final result = await repo.updateProfile(
      name: name,
      location: location,
      phone: phone,
    );
    result.fold(
          (failure) => emit(ProfileFailure(message: failure.message)),
          (user) => emit(ProfileUpdateSuccess(user: user)),
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(ProfileLoading());
    final result = await repo.changePassword(
      currentPassword: currentPassword,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    result.fold(
          (failure) => emit(ProfileFailure(message: failure.message)),
          (_) => emit(ChangePasswordSuccess()),
    );
  }



  Future<void> deleteAccount() async {
    emit(ProfileLoading());
    final result = await repo.deleteAccount();
    result.fold(
          (failure) => emit(ProfileFailure(message: failure.message)),
          (_) => emit(DeleteAccountSuccess()),
    );
  }
}