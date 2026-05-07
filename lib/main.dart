import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:real_estate_1a/core/bloc observe/bloc_service.dart';
import 'package:real_estate_1a/core/di/di.dart';

import 'package:real_estate_1a/features/home/presentation/cubit/appbar/app_bar_cubit.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/chat/chat_cubit.dart';

import 'package:real_estate_1a/features/home/presentation/pages/home_screen.dart';

import 'features/home/presentation/pages/chat_screen.dart';
import 'features/home/presentation/pages/conversation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

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
      ],

      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,

        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,

          home: const HomeScreen(),

          routes: {
             HomeScreen.routeName:(context)=>HomeScreen(),
            ConversationsScreen.routeName: (context) =>
            const ConversationsScreen(),

            ChatScreen.routeName: (context) {

              final conversationId =
              ModalRoute.of(context)!
                  .settings
                  .arguments as int;

              return ChatScreen(
                conversationId: conversationId,
              );
            },
          },
        ),
      ),
    );
  }
}