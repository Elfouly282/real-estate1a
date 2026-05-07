import '../../domain/entities/property_details_entity.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsSuccess extends DetailsState {
  final PropertyDetailsEntity property;
  DetailsSuccess({required this.property});
}

class DetailsFailure extends DetailsState {
  final String message;
  DetailsFailure({required this.message});
}