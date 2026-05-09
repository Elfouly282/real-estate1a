import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/features/profile/presentation/screens/profile_screen.dart';
import 'package:real_estate_1a/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/property_details/presentation/screens/property_details_screen.dart';
import 'firebase_options.dart';

import 'core/di.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const ProfileScreen(),
      ),
    );
  }
}


