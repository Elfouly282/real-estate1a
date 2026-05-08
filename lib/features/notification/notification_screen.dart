import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import 'cubit/notification_cubit.dart';

class NotificationsScreen extends StatelessWidget {
  static String routeName="/notificatioScreen";
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              notificationCubit.clear();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit,
          List<Map<String, dynamic>>>(
        bloc: notificationCubit,
        builder: (context, notifications) {
          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                "No notifications yet 🔔",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: notifications.length,
            separatorBuilder: (_, __) =>
            const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final n = notifications[index];

              final type = n['type'];

              return InkWell(
                onTap: () {
                  // Navigation based on type
                  if (type == 'chat') {
                    Navigator.pushNamed(
                      context,
                      '/chat',
                      arguments: n['id'],
                    );
                  } else if (type == 'property') {
                    Navigator.pushNamed(
                      context,
                      '/propertyDetails',
                      arguments: n['id'],
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: _getColor(type),
                        child: Icon(
                          _getIcon(type),
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              n['title'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              n['body'] ?? '',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // 🎯 Icons based on type
  IconData _getIcon(String? type) {
    switch (type) {
      case 'chat':
        return Icons.chat;
      case 'property':
        return Icons.home;
      default:
        return Icons.notifications;
    }
  }

  // 🎨 Colors based on type
  Color _getColor(String? type) {
    switch (type) {
      case 'chat':
        return Colors.blue;
      case 'property':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}