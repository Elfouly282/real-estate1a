import '../../domain/entities/review_entity.dart';

abstract class ReviewsState {}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsSuccess extends ReviewsState {
  final List<ReviewEntity> reviews;
  ReviewsSuccess({required this.reviews});
}

class ReviewsFailure extends ReviewsState {
  final String message;
  ReviewsFailure({required this.message});
}