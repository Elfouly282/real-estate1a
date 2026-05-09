// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:real_estate_1a/core/api/api_manager.dart' as _i779;
import 'package:real_estate_1a/core/api/dio_helper.dart' as _i839;
import 'package:real_estate_1a/core/service/location_service.dart' as _i677;
import 'package:real_estate_1a/features/auth/data/repositories/auth_repo_impl.dart'
    as _i921;
import 'package:real_estate_1a/features/auth/domain/repos/auth_repo.dart'
    as _i941;
import 'package:real_estate_1a/features/auth/presentation/cubit/auth_cubit.dart'
    as _i785;
import 'package:real_estate_1a/features/favourite/data/datasource/favorites_datasource_impl.dart'
    as _i514;
import 'package:real_estate_1a/features/favourite/data/repositories/favorites_repository_impl.dart'
    as _i471;
import 'package:real_estate_1a/features/favourite/domain/repositories/datasource/favorites_datasource.dart'
    as _i812;
import 'package:real_estate_1a/features/favourite/domain/repositories/repositories/favorites_repository.dart'
    as _i570;
import 'package:real_estate_1a/features/favourite/domain/usecases/favorites_usecases.dart'
    as _i644;
import 'package:real_estate_1a/features/favourite/pressentation/cubit/favorites_cubit.dart'
    as _i270;
import 'package:real_estate_1a/features/history/data/datasource/history_datasource_impl.dart'
    as _i853;
import 'package:real_estate_1a/features/history/data/repositories/history_repository_impl.dart'
    as _i1063;
import 'package:real_estate_1a/features/history/domain/repositories/datasource/history_datasource.dart'
    as _i896;
import 'package:real_estate_1a/features/history/domain/repositories/repositories/history_repository.dart'
    as _i632;
import 'package:real_estate_1a/features/history/domain/usecases/history_usecases.dart'
    as _i670;
import 'package:real_estate_1a/features/history/presentation/cubit/history_cubit.dart'
    as _i754;
import 'package:real_estate_1a/features/home/data/datasources/chat_datasource_impl.dart'
    as _i565;
import 'package:real_estate_1a/features/home/data/datasources/home_datasource_impl.dart'
    as _i207;
import 'package:real_estate_1a/features/home/data/repositories/chat_repository_impl.dart'
    as _i461;
import 'package:real_estate_1a/features/home/data/repositories/home_repository_impl.dart'
    as _i617;
import 'package:real_estate_1a/features/home/domain/repositories/datasource/chat_datasource.dart'
    as _i428;
import 'package:real_estate_1a/features/home/domain/repositories/datasource/home_datasource.dart'
    as _i992;
import 'package:real_estate_1a/features/home/domain/repositories/repositories/chat_repository.dart'
    as _i335;
import 'package:real_estate_1a/features/home/domain/repositories/repositories/home_repository.dart'
    as _i65;
import 'package:real_estate_1a/features/home/domain/usecases/chat_usecase.dart'
    as _i509;
import 'package:real_estate_1a/features/home/domain/usecases/home_usecase.dart'
    as _i954;
import 'package:real_estate_1a/features/home/presentation/cubit/appbar/app_bar_cubit.dart'
    as _i365;
import 'package:real_estate_1a/features/home/presentation/cubit/chat/chat_cubit.dart'
    as _i66;
import 'package:real_estate_1a/features/home/presentation/cubit/home/home_cubit.dart'
    as _i979;
import 'package:real_estate_1a/features/maps/data/datasources/remote/home_api_datasource.dart'
    as _i842;
import 'package:real_estate_1a/features/maps/data/datasources/remote/home_datasource.dart'
    as _i767;
import 'package:real_estate_1a/features/maps/data/repositories/home_repository_impl.dart'
    as _i1045;
import 'package:real_estate_1a/features/maps/domain/repo/home_repository.dart'
    as _i241;
import 'package:real_estate_1a/features/maps/domain/usecase/get_marker.dart'
    as _i384;
import 'package:real_estate_1a/features/maps/presentation/cubit/markers_cubit.dart'
    as _i522;
import 'package:real_estate_1a/features/profile/data/profile_repo_impl.dart'
    as _i894;
import 'package:real_estate_1a/features/profile/domain/profile_repo.dart'
    as _i5;
import 'package:real_estate_1a/features/profile/presentation/cubit/profile_cubit.dart'
    as _i929;
import 'package:real_estate_1a/features/property_details/data/repositories/property_details_repo_impl.dart'
    as _i218;
import 'package:real_estate_1a/features/property_details/data/repositories/reviews_repo_impl.dart'
    as _i864;
import 'package:real_estate_1a/features/property_details/data/repositories/similar_properties_repo_impl.dart'
    as _i1044;
import 'package:real_estate_1a/features/property_details/domain/repos/property_details_repo.dart'
    as _i366;
import 'package:real_estate_1a/features/property_details/domain/repos/reviews_repo.dart'
    as _i56;
import 'package:real_estate_1a/features/property_details/domain/repos/similar_properties_repo.dart'
    as _i596;
import 'package:real_estate_1a/features/property_details/presentation/cubit/property_details_cubit.dart'
    as _i756;
import 'package:real_estate_1a/features/property_details/presentation/cubit/reviews_cubit.dart'
    as _i472;
import 'package:real_estate_1a/features/property_details/presentation/cubit/similar_properties_cubit.dart'
    as _i653;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i677.LocationService>(() => _i677.LocationService());
    gh.singleton<_i839.DioHelper>(() => _i839.DioHelper());
    gh.lazySingleton<_i596.SimilarPropertiesRepo>(
      () => _i1044.SimilarPropertiesRepoImpl(),
    );
    gh.lazySingleton<_i366.DetailsRepo>(() => _i218.DetailsRepoImpl());
    gh.lazySingleton<_i779.ApiManager>(() => _i779.ApiManager(gh<_i361.Dio>()));
    gh.factory<_i653.SimilarPropertiesCubit>(
      () =>
          _i653.SimilarPropertiesCubit(repo: gh<_i596.SimilarPropertiesRepo>()),
    );
    gh.lazySingleton<_i5.ProfileRepo>(() => _i894.ProfileRepoImpl());
    gh.lazySingleton<_i56.ReviewsRepo>(() => _i864.ReviewsRepoImpl());
    gh.lazySingleton<_i941.AuthRepo>(() => _i921.AuthRepoImpl());
    gh.factory<_i428.ChatDatasource>(
      () => _i565.ChatDatasourceImpl(apiManager: gh<_i779.ApiManager>()),
    );
    gh.factory<_i785.AuthCubit>(
      () => _i785.AuthCubit(repo: gh<_i941.AuthRepo>()),
    );
    gh.factory<_i472.ReviewsCubit>(
      () => _i472.ReviewsCubit(repo: gh<_i56.ReviewsRepo>()),
    );
    gh.factory<_i756.DetailsCubit>(
      () => _i756.DetailsCubit(repo: gh<_i366.DetailsRepo>()),
    );
    gh.factory<_i365.AppBarCubit>(
      () => _i365.AppBarCubit(locationService: gh<_i677.LocationService>()),
    );
    gh.factory<_i812.FavoritesDatasource>(
      () => _i514.FavoritesRemoteDatasource(gh<_i779.ApiManager>()),
    );
    gh.factory<_i929.ProfileCubit>(
      () => _i929.ProfileCubit(repo: gh<_i5.ProfileRepo>()),
    );
    gh.factory<_i896.HistoryDatasource>(
      () => _i853.HistoryRemoteDatasource(gh<_i779.ApiManager>()),
    );
    gh.lazySingleton<_i767.HomeDatasource>(
      () => _i842.HomeApiDatasource(gh<_i779.ApiManager>()),
    );
    gh.factory<_i992.HomeDatasource>(
      () => _i207.HomeRemoteDataSourceImpl(gh<_i779.ApiManager>()),
    );
    gh.factory<_i335.ChatRepository>(
      () => _i461.ChatRepositoryImpl(datasource: gh<_i428.ChatDatasource>()),
    );
    gh.lazySingleton<_i241.HomeRepository>(
      () => _i1045.HomeRepositoryImpl(gh<_i767.HomeDatasource>()),
    );
    gh.factory<_i632.HistoryRepository>(
      () => _i1063.HistoryRepositoryImpl(gh<_i896.HistoryDatasource>()),
    );
    gh.factory<_i509.ListConversationUsecase>(
      () =>
          _i509.ListConversationUsecase(repository: gh<_i335.ChatRepository>()),
    );
    gh.factory<_i509.GetConversationAndMessageUseCase>(
      () => _i509.GetConversationAndMessageUseCase(
        repository: gh<_i335.ChatRepository>(),
      ),
    );
    gh.factory<_i509.SendMessageUseCase>(
      () => _i509.SendMessageUseCase(repository: gh<_i335.ChatRepository>()),
    );
    gh.factory<_i509.StartConversationUseCase>(
      () => _i509.StartConversationUseCase(
        repository: gh<_i335.ChatRepository>(),
      ),
    );
    gh.factory<_i65.HomeRepository>(
      () => _i617.HomeRepositoryImpl(gh<_i992.HomeDatasource>()),
    );
    gh.factory<_i570.FavoritesRepository>(
      () => _i471.FavoritesRepositoryImpl(gh<_i812.FavoritesDatasource>()),
    );
    gh.factory<_i66.ChatCubit>(
      () => _i66.ChatCubit(
        listConversationUsecase: gh<_i509.ListConversationUsecase>(),
        getConversationAndMessageUseCase:
            gh<_i509.GetConversationAndMessageUseCase>(),
        sendMessageUseCase: gh<_i509.SendMessageUseCase>(),
        startConversationUseCase: gh<_i509.StartConversationUseCase>(),
      ),
    );
    gh.lazySingleton<_i384.GetMarkerUsecase>(
      () => _i384.GetMarkerUsecase(gh<_i241.HomeRepository>()),
    );
    gh.factory<_i522.MarkersCubit>(
      () => _i522.MarkersCubit(gh<_i384.GetMarkerUsecase>()),
    );
    gh.factory<_i670.GetHistoryUseCase>(
      () => _i670.GetHistoryUseCase(gh<_i632.HistoryRepository>()),
    );
    gh.factory<_i644.GetFavoritesUseCase>(
      () => _i644.GetFavoritesUseCase(gh<_i570.FavoritesRepository>()),
    );
    gh.factory<_i644.AddFavoriteUseCase>(
      () => _i644.AddFavoriteUseCase(gh<_i570.FavoritesRepository>()),
    );
    gh.factory<_i644.RemoveFavoriteUseCase>(
      () => _i644.RemoveFavoriteUseCase(gh<_i570.FavoritesRepository>()),
    );
    gh.factory<_i954.HomeDataUseCase>(
      () => _i954.HomeDataUseCase(gh<_i65.HomeRepository>()),
    );
    gh.factory<_i270.FavoritesCubit>(
      () => _i270.FavoritesCubit(
        getFavoritesUseCase: gh<_i644.GetFavoritesUseCase>(),
        addFavoriteUseCase: gh<_i644.AddFavoriteUseCase>(),
        removeFavoriteUseCase: gh<_i644.RemoveFavoriteUseCase>(),
      ),
    );
    gh.factory<_i754.HistortyCubit>(
      () =>
          _i754.HistortyCubit(getHistoryUseCase: gh<_i670.GetHistoryUseCase>()),
    );
    gh.factory<_i979.HomeCubit>(
      () => _i979.HomeCubit(getHomeDataUseCase: gh<_i954.HomeDataUseCase>()),
    );
    return this;
  }
}
