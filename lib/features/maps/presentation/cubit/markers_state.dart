part of 'markers_cubit.dart';

@immutable
sealed class MarkersState {}

final class MarkersInitial extends MarkersState {}
final class MarkersLoading extends MarkersState {}

final class MarkersLoaded extends MarkersState {
  final List<MarkerEntity> markers;
  MarkersLoaded(this.markers);
}

final class MarkersError extends MarkersState {
  final String message;
  MarkersError(this.message);
} 