// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:real_estate_1a/features/auth/data/repositories/auth_repo_impl.dart'
    as _i921;
import 'package:real_estate_1a/features/auth/domain/repos/auth_repo.dart'
    as _i941;
import 'package:real_estate_1a/features/auth/presentation/cubit/auth_cubit.dart'
    as _i785;
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
    gh.lazySingleton<_i596.SimilarPropertiesRepo>(
      () => _i1044.SimilarPropertiesRepoImpl(),
    );
    gh.lazySingleton<_i366.DetailsRepo>(() => _i218.DetailsRepoImpl());
    gh.factory<_i653.SimilarPropertiesCubit>(
      () =>
          _i653.SimilarPropertiesCubit(repo: gh<_i596.SimilarPropertiesRepo>()),
    );
    gh.lazySingleton<_i56.ReviewsRepo>(() => _i864.ReviewsRepoImpl());
    gh.lazySingleton<_i941.AuthRepo>(() => _i921.AuthRepoImpl());
    gh.factory<_i785.AuthCubit>(
      () => _i785.AuthCubit(repo: gh<_i941.AuthRepo>()),
    );
    gh.factory<_i472.ReviewsCubit>(
      () => _i472.ReviewsCubit(repo: gh<_i56.ReviewsRepo>()),
    );
    gh.factory<_i756.DetailsCubit>(
      () => _i756.DetailsCubit(repo: gh<_i366.DetailsRepo>()),
    );
    return this;
  }
}
