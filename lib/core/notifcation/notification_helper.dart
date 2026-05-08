import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../features/notification/cubit/notification_cubit.dart';

class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin fln,
      NotificationCubit cubit,
      GlobalKey<NavigatorState> navigatorKey,
      ) async {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInit =
    DarwinInitializationSettings();

    final InitializationSettings settings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await fln.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        log('🔘 Local notification clicked: ${response.payload}');
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default_channel',
      'Default',
      description: 'Default notifications',
      importance: Importance.max,
    );

    await fln
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// 🔔 Foreground messages
    FirebaseMessaging.onMessage.listen((message) async {
      await showNotification(message, fln);

      final data = {
        "title": message.notification?.title ?? message.data['title'],
        "body": message.notification?.body ?? message.data['body'],
        "type": message.data['type'] ?? "general",
        "id": message.data['id'],
      };

      cubit.addNotification(data);
    });

    /// 📲 Click notification (background)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('Notification clicked: ${message.data}');
      _handleNavigation(message.data, navigatorKey);
    });

    /// 🚀 Terminated state
    final initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      log('Opened from terminated notification');
      _handleNavigation(initialMessage.data, navigatorKey);
    }
  }

  static Future<void> showNotification(
      RemoteMessage message,
      FlutterLocalNotificationsPlugin fln,
      ) async {
    final title = message.notification?.title ?? message.data['title'];
    final body = message.notification?.body ?? message.data['body'];

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'default_channel',
      'Default',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await fln.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: message.data.toString(),
    );
  }

  static void _handleNavigation(
      Map<String, dynamic> data,
      GlobalKey<NavigatorState> navigatorKey,
      ) {
    final type = data['type'];

    if (type == 'conversations') {
      navigatorKey.currentState?.pushNamed(
        '/conversations',
        arguments: data['id'],
      );
    }

    if (type == 'property') {
      navigatorKey.currentState?.pushNamed(
        '/propertyDetails',
        arguments: data['id'],
      );
    }
  }
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    log('🔔 Background message: ${message.data}');
  }
}