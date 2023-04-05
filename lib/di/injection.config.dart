// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../core/network/network_info.dart' as _i4;
import '../features/number_trivia/data/datasources/number_trivia_local_data_source.dart'
    as _i7;
import '../features/number_trivia/data/datasources/number_trivia_remote_data_source.dart'
    as _i5;
import '../features/number_trivia/data/repositories/number_trivia_repository_impl.dart'
    as _i9;
import '../features/number_trivia/domain/repositories/number_trivia_repository.dart'
    as _i8;
import '../features/number_trivia/domain/usecases/get_concrete_number_trivia.dart'
    as _i10;
import '../features/number_trivia/domain/usecases/get_random_number_trivia.dart'
    as _i11;
import '../features/number_trivia/presentation/statemanagement/number_trivia_state.dart'
    as _i12;
import 'register_module.dart' as _i13;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    final sharedModule = _$SharedModule();
    gh.singleton<_i3.Client>(registerModule.client);
    gh.singleton<_i4.NetworkInfo>(_i4.NetworkInfoImpl());
    gh.singleton<_i5.NumberTriviaRemoteDataSource>(
        _i5.NumberTriviaRemoteDataSourceImpl(client: gh<_i3.Client>()));
    await gh.factoryAsync<_i6.SharedPreferences>(
      () => sharedModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i7.NumberTriviaLocalDataSource>(
        _i7.NumberTriviaLocalDataSourceImpl(gh<_i6.SharedPreferences>()));
    gh.singleton<_i8.NumberTriviaRepository>(_i9.NumberTriviaRepositoryImpl(
      localDataSource: gh<_i7.NumberTriviaLocalDataSource>(),
      remoteDataSource: gh<_i5.NumberTriviaRemoteDataSource>(),
      networkInfo: gh<_i4.NetworkInfo>(),
    ));
    gh.singleton<_i10.GetConcreteNumberTrivia>(
        _i10.GetConcreteNumberTrivia(gh<_i8.NumberTriviaRepository>()));
    gh.factory<_i11.GetRandomNumberTrivia>(
        () => _i11.GetRandomNumberTrivia(gh<_i8.NumberTriviaRepository>()));
    gh.factory<_i12.NumberTriviaNotifier>(() => _i12.NumberTriviaNotifier(
          getConcreteNumberTriviaUseCase: gh<_i10.GetConcreteNumberTrivia>(),
          getRandomNumberTriviaUseCase: gh<_i11.GetRandomNumberTrivia>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i13.RegisterModule {}

class _$SharedModule extends _i13.SharedModule {}
