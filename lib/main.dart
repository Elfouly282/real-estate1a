import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/features/favourite/pressentation/cubit/favorites_cubit.dart';
import 'package:real_estate_1a/features/property_details/presentation/screens/property_details_screen.dart';

import 'core/bloc observe/bloc_service.dart';
import 'core/di/di.dart';
import 'features/home/presentation/cubit/appbar/app_bar_cubit.dart';
import 'features/home/presentation/cubit/chat/chat_cubit.dart';
import 'features/home/presentation/pages/chat_screen.dart';
import 'features/home/presentation/pages/conversation_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureDependencies();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBarCubit>(
          create: (_) => getIt<AppBarCubit>(),
        ),
        BlocProvider<ChatCubit>(
          create: (_) => getIt<ChatCubit>(),
        ),
        BlocProvider<FavoritesCubit>(create: (_)=>getIt<FavoritesCubit>())
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
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
            PropertyDetailsScreen.routeName:(context){
              final propertyId = ModalRoute.of(context)!.settings.arguments as int;

              return PropertyDetailsScreen(propertyId: propertyId);
            }
          },
        ),
      ),
    );
  }
}
