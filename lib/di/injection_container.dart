import 'package:clean_architecture_flutter/core/network/network_info.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_flutter/features/number_trivia/presentation/statemanagement/number_trivia_state.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerSingleton<NetworkInfo>(NetworkInfoImpl());
  // External
  sl.registerSingletonAsync(() => SharedPreferences.getInstance());
  sl.registerSingleton<http.Client>(http.Client());

  // Data sources
  sl.registerSingleton<NumberTriviaRemoteDataSource>(
    NumberTriviaRemoteDataSourceImpl(client: sl()),
  );
  sl.registerSingleton<NumberTriviaLocalDataSource>(
      NumberTriviaLocalDataSourceImpl(
          sharedPreferences: await sl.getAsync<SharedPreferences>()));
  // Repository
  sl.registerSingleton<NumberTriviaRepository>(NumberTriviaRepositoryImpl(
    localDataSource: sl(),
    remoteDataSource: sl<NumberTriviaRemoteDataSource>(),
    networkInfo: sl<NetworkInfo>(),
  ));
  // UseCases
  sl.registerSingleton(GetConcreteNumberTrivia(sl<NumberTriviaRepository>()));
  sl.registerSingleton(GetRandomNumberTrivia(sl<NumberTriviaRepository>()));

  // Features
  sl.registerFactory(
    () => NumberTriviaNotifier(
        getConcreteNumberTriviaUseCase: sl(),
        getRandomNumberTriviaUseCase: sl()),
  );
}
