import '../../../domain/entities/home_response_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeResponseEntity data;
  HomeSuccess(this.data);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}