part of 'history_cubit.dart';

abstract class HistoryState {}

class HistoryInitial  extends HistoryState {}
class HistoryLoading  extends HistoryState {}

class HistorySuccess extends HistoryState {
  final HistoryEntity data;
  HistorySuccess(this.data);
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}