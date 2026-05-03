// di.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../save data/save_data.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // 1 ← init CacheHelper الأول
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  getIt.registerLazySingleton<CacheHelper>(() => cacheHelper);

  // 2 ← register Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // 3 ← register الباقي
  getIt.init();
}