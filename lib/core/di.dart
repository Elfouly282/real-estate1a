import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../features/auth/data/repositories/auth_repo_impl.dart';
import '../features/auth/domain/repos/auth_repo.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/property_details/data/repositories/property_details_repo_impl.dart';
import '../features/property_details/data/repositories/reviews_repo_impl.dart';
import '../features/property_details/data/repositories/similar_properties_repo_impl.dart';
import '../features/property_details/domain/repos/property_details_repo.dart';
import '../features/property_details/domain/repos/reviews_repo.dart';
import '../features/property_details/domain/repos/similar_properties_repo.dart';
import '../features/property_details/presentation/cubit/reviews_cubit.dart';
import '../features/property_details/presentation/cubit/similar_properties_cubit.dart';
import 'save data/save_data.dart';
import 'security/security_helper.dart';
import 'api/dio_helper.dart';
import 'api/internet_connection_checker.dart';


final GetIt getIt = GetIt.instance;

Future<void> initAppModule() async {
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  getIt.registerLazySingleton<CacheHelper>(() => cacheHelper);

  final securityHelper = SecurityHelper();
  getIt.registerLazySingleton<SecurityHelper>(() => securityHelper);

  final authStorage = AuthStorage(getIt<SecurityHelper>());
  await authStorage.migrateFromCacheIfNeeded(cacheHelper);
  await authStorage.loadFromSecure();
  getIt.registerLazySingleton<AuthStorage>(() => authStorage);

  await DioHelper.init();
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());

  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
  );


////////

  getIt.registerLazySingleton<AuthRepo>(
        () => AuthRepoImpl(),
  );

  getIt.registerFactory(
        () => AuthCubit(repo: getIt<AuthRepo>()),
  );

  getIt.registerLazySingleton<DetailsRepo>(
        () => DetailsRepoImpl(),
  );

  getIt.registerLazySingleton<ReviewsRepo>(
        () => ReviewsRepoImpl(),
  );

  getIt.registerFactory(
        () => ReviewsCubit(repo: getIt<ReviewsRepo>()),
  );


  getIt.registerLazySingleton<SimilarPropertiesRepo>(
        () => SimilarPropertiesRepoImpl(),
  );

  getIt.registerFactory(
        () => SimilarPropertiesCubit(repo: getIt<SimilarPropertiesRepo>()),
  );

}
