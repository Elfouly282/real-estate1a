import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../features/notification/cubit/notification_cubit.dart';
import '../../firebase_options.dart';

class NotificationHelper {
  static Future<void> initialize(
    FlutterLocalNotificationsPlugin fln,
    NotificationCubit cubit,
    GlobalKey<NavigatorState> navigatorKey,
  ) async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await fln.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        log('Local notification clicked: ${response.payload}');
        final payload = response.payload;

        if (payload == null || payload.isEmpty) {
          return;
        }

        final data = jsonDecode(payload);
        if (data is Map<String, dynamic>) {
          _handleNavigation(data, navigatorKey);
        }
      },
    );

    const channel = AndroidNotificationChannel(
      'default_channel',
      'Default',
      description: 'Default notifications',
      importance: Importance.max,
    );

    await fln
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((message) async {
      await showNotification(message, fln);

      final data = {
        'title': message.notification?.title ?? message.data['title'],
        'body': message.notification?.body ?? message.data['body'],
        'type': message.data['type'] ?? 'general',
        'id': message.data['id'],
      };

      cubit.addNotification(data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('Notification clicked: ${message.data}');
      _handleNavigation(message.data, navigatorKey);
    });

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

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

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await fln.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: jsonEncode(message.data),
    );
  }

  static void _handleNavigation(
    Map<String, dynamic> data,
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    final type = data['type'];
    final id = (data['id'] as num?)?.toInt() ??
        int.tryParse(data['id']?.toString() ?? '');

    if (id == null) {
      log('Notification id is missing: $data');
      return;
    }

    if (type == 'chat' || type == 'conversation' || type == 'conversations') {
      navigatorKey.currentState?.pushNamed('/chatScreen', arguments: id);
      return;
    }

    if (type == 'property') {
      navigatorKey.currentState?.pushNamed('/propertyDetails', arguments: id);
    }
  }
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    log('Background message: ${message.data}');
  }
}
