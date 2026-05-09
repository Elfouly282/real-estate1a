

import '../../../auth/domain/entities/user_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserEntity user;
  ProfileSuccess({required this.user});
}

class DeleteAccountSuccess extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final UserEntity user;
  ProfileUpdateSuccess({required this.user});
}

class ChangePasswordSuccess extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure({required this.message});
}