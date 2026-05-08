import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:real_estate_1a/features/property_details/presentation/screens/property_details_screen.dart';

import '../../core/constant/custom_svg_image.dart';
import '../../gen/assets.gen.dart';
import '../../main.dart';
import '../home/presentation/pages/chat_screen.dart';
import 'cubit/notification_cubit.dart';

class NotificationsScreen extends StatelessWidget {
  static const String routeName = "/notificationScreen";

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
              context.read<NotificationCubit>().clear();
            },
          ),
          InkWell(child: CustomSvgImage(path: Assets.svg.activeNotification),onTap: () async{
            const AndroidNotificationDetails androidDetails =
            AndroidNotificationDetails(
              'Test Notification',
              'Default',
              importance: Importance.max,
              priority: Priority.max,
            );
            const NotificationDetails details =
            NotificationDetails(android: androidDetails);
            await fln.show(
              1,
              'Test Notification 🔔',
              'This is a local test',
              details,
            );
          },)

        ],
      ),
      body: BlocBuilder<NotificationCubit, List<Map<String, dynamic>>>(
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
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final n = notifications[index];
              final type = n['type'];

              return InkWell(
                onTap: () {
                  _handleNavigation(context, n);
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

  /// 🔥 Navigation Handler
  void _handleNavigation(
      BuildContext context, Map<String, dynamic> data) {
    final type = data['type'];
    final id = (data['id'] as num?)?.toInt() ??
        int.tryParse(data['id']?.toString() ?? '');

    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notification id is missing")),
      );
      return;
    }

    if (type == 'chat' || type == 'conversation' || type == 'conversations') {
      Navigator.pushNamed(
        context,
        ChatScreen.routeName,
        arguments: id,
      );
    } else if (type == 'property') {
      Navigator.pushNamed(
        context,
        PropertyDetailsScreen.routeName,
        arguments: id,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unknown notification type")),
      );
    }
  }

  // 🎯 Icons based on type
  IconData _getIcon(String? type) {
    switch (type) {
      case 'chat':
      case 'conversation':
      case 'conversations':
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
      case 'conversation':
      case 'conversations':
        return Colors.blue;
      case 'property':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}
