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

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i677.LocationService>(() => _i677.LocationService());
    gh.singleton<_i839.DioHelper>(() => _i839.DioHelper());
    gh.lazySingleton<_i779.ApiManager>(() => _i779.ApiManager(gh<_i361.Dio>()));
    gh.factory<_i428.ChatDatasource>(
      () => _i565.ChatDatasourceImpl(apiManager: gh<_i779.ApiManager>()),
    );
    gh.factory<_i365.AppBarCubit>(
      () => _i365.AppBarCubit(locationService: gh<_i677.LocationService>()),
    );
    gh.factory<_i812.FavoritesDatasource>(
      () => _i514.FavoritesRemoteDatasource(gh<_i779.ApiManager>()),
    );
    gh.factory<_i896.HistoryDatasource>(
      () => _i853.HistoryRemoteDatasource(gh<_i779.ApiManager>()),
    );
    gh.factory<_i992.HomeDatasource>(
      () => _i207.HomeRemoteDataSourceImpl(gh<_i779.ApiManager>()),
    );
    gh.factory<_i335.ChatRepository>(
      () => _i461.ChatRepositoryImpl(datasource: gh<_i428.ChatDatasource>()),
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
