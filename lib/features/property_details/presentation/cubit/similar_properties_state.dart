import '../../domain/entities/property_details_entity.dart';

abstract class SimilarPropertiesState {}

class SimilarPropertiesInitial extends SimilarPropertiesState {}

class SimilarPropertiesLoading extends SimilarPropertiesState {}

class SimilarPropertiesSuccess extends SimilarPropertiesState {
  final List<PropertyDetailsEntity> properties;
  SimilarPropertiesSuccess({required this.properties});
}

class SimilarPropertiesFailure extends SimilarPropertiesState {
  final String message;
  SimilarPropertiesFailure({required this.message});
}