import 'package:clean_architecture_flutter/data/datasource/number_trivia_local_data_source.dart';
import 'package:clean_architecture_flutter/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter/data/network/NetworkInfo.dart';
import 'package:clean_architecture_flutter/data/repository/NumberTriviaRepositoryImpl.dart';
import 'package:clean_architecture_flutter/domain/repository/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_repository_test.mocks.dart';

@GenerateMocks(
    [NumberTriviaRemoteDataSource, NumberTriviaLocalDatasource, NetworkInfo])
void main() {
  late NumberTriviaRepository repository;
  late NetworkInfo networkInfo;
  late NumberTriviaLocalDatasource localDatasource;
  late NumberTriviaRemoteDataSource remoteDataSource;
  setUp(() {
    networkInfo = MockNetworkInfo();
    localDatasource = MockNumberTriviaLocalDatasource();
    remoteDataSource = MockNumberTriviaRemoteDataSource();
    repository = NumberTriviaRepositoryImpl(
      networkInfo,
      localDatasource,
      remoteDataSource,
    );
  });

  group('device online', () {
    setUp(() {
      when(networkInfo.isConnect()).thenAnswer((_) async => true);
    });
    group('get concrete number trivia', () {
      test('should check network before', () async {
        repository.getConcreteNumberTrivia(1);
        verify(networkInfo.isConnect());
      });
    });
  });
}
