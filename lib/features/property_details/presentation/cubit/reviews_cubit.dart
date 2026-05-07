import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repos/reviews_repo.dart';
import 'reviews_state.dart';


@injectable
class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsRepo repo;

  ReviewsCubit({required this.repo}) : super(ReviewsInitial());

  Future<void> getPropertyReviews({required int propertyId}) async {
    emit(ReviewsLoading());

    final result = await repo.getPropertyReviews(propertyId: propertyId);

    result.fold(
          (failure) => emit(ReviewsFailure(message: failure.message)),
          (reviews) => emit(ReviewsSuccess(reviews: reviews)),
    );
  }
}