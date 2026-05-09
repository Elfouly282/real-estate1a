import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/features/payment/presentation/screens/paymetscreen.dart';
import 'package:real_estate_1a/features/profile/presentation/screens/profile_screen.dart';
import 'package:real_estate_1a/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:real_estate_1a/features/favourite/pressentation/cubit/favorites_cubit.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:real_estate_1a/features/maps/presentation/cubit/markers_cubit.dart';
import 'package:real_estate_1a/features/notification/notification_screen.dart';
import 'package:real_estate_1a/features/property_details/presentation/screens/property_details_screen.dart';
import 'core/bloc observe/bloc_service.dart';
import 'core/di/di.dart';
import 'core/notifcation/fcm_service.dart';
import 'core/notifcation/notification_helper.dart';
import 'features/home/presentation/cubit/appbar/app_bar_cubit.dart';
import 'features/home/presentation/cubit/chat/chat_cubit.dart';
import 'features/home/presentation/pages/chat_screen.dart';
import 'features/home/presentation/pages/conversation_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/notification/cubit/notification_cubit.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();

final NotificationCubit notificationCubit = NotificationCubit();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();

  await Hive.openBox('notificationsBox');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  await requestNotificationPermission();
  await FcmService.initialize();

  await NotificationHelper.initialize(fln, notificationCubit, navigatorKey);

  runApp(BlocProvider.value(value: notificationCubit, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        
        BlocProvider(create: (_) => getIt<MarkersCubit>()),
        BlocProvider<AppBarCubit>(create: (_) => getIt<AppBarCubit>()),
        BlocProvider<ChatCubit>(create: (_) => getIt<ChatCubit>()),
        BlocProvider<HomeCubit>(create: (_) => getIt<HomeCubit>()),
        BlocProvider<FavoritesCubit>(create: (_) => getIt<FavoritesCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          navigatorKey: navigatorKey,
          routes: {
            Paymetscreen.routeName: (_)=>Paymetscreen() ,
            HomeScreen.routeName: (context) => const HomeScreen(),
            NotificationsScreen.routeName: (context) => NotificationsScreen(),
            ConversationsScreen.routeName: (context) {
              final args = ModalRoute.of(context)?.settings.arguments;

              if (args is Map) {
                return ConversationsScreen(
                  agentUserId: (args['agentUserId'] as num?)?.toInt(),
                  propertyId: (args['propertyId'] as num?)?.toInt(),
                );
              }
              return const ConversationsScreen();
            },
            ChatScreen.routeName: (context) {
              final conversationId =
                  ModalRoute.of(context)!.settings.arguments as int;

              return ChatScreen(conversationId: conversationId);
            },
            PropertyDetailsScreen.routeName: (context) {
              final propertyId =
                  ModalRoute.of(context)!.settings.arguments as int;

              return PropertyDetailsScreen(propertyId: propertyId);
            },
          },
        ),
      ),
    );
  }
}

Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
    announcement: false,
    carPlay: false,
    criticalAlert: false,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('Provisional permission granted');
  } else {
    print('Permission denied');
  }
}
