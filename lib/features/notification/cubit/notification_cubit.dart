import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificationCubit extends Cubit<List<Map<String, dynamic>>> {
  final Box box = Hive.box('notificationsBox');

  NotificationCubit() : super([]) {
    loadNotifications();
  }
  void loadNotifications() {
    final data = box.get('notifications', defaultValue: []);
    emit(List<Map<String, dynamic>>.from(data));
  }
  void addNotification(Map<String, dynamic> notification) {
    final updated = [...state, notification];

    box.put('notifications', updated);
    emit(updated);
  }

  void clear() {
    box.put('notifications', []);
    emit([]);
  }
}