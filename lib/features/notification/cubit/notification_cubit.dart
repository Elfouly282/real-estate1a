import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<List<Map<String, dynamic>>> {
  NotificationCubit() : super([]);

  void addNotification(Map<String, dynamic> notification) {
    emit([...state, notification]);
  }

  void clear() {
    emit([]);
  }
}