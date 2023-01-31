import 'package:clean_architecture_flutter/core/error/failure.dart';
import 'package:clean_architecture_flutter/core/network/network_info.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks(
    [NumberTriviaRemoteDataSource, NumberTriviaLocalDataSource, NetworkInfo])
void main() {
  late MockNumberTriviaLocalDataSource localDataSource;
  late MockNumberTriviaRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late NumberTriviaRepositoryImpl repositoryImpl;

  setUp(() {
    localDataSource = MockNumberTriviaLocalDataSource();
    remoteDataSource = MockNumberTriviaRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
        localDataSource: localDataSource,
        remoteDataSource: remoteDataSource,
        networkInfo: networkInfo);
  });

  group('device online', () {
    final tNumberTriviaModel = NumberTriviaModel(text: 'test', number: 1);
    setUp(() {
      when(networkInfo.isConnected()).thenAnswer((_) => true);
    });
    test('get concrete-return correctly data when server return data',
        () async {
      when(remoteDataSource.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTriviaModel);
      final result = await repositoryImpl.getConcreteNumberTrivia(1);
      expect(result, Right(tNumberTriviaModel));
      verify(localDataSource.cacheNumberTrivia(tNumberTriviaModel));
    });

    test('get concrete-return server failure data when server return exception',
        () async {
      when(remoteDataSource.getConcreteNumberTrivia(any))
          .thenThrow(Exception());
      final result = await repositoryImpl.getConcreteNumberTrivia(1);
      expect(result, Left(ServerFailure()));
      verifyZeroInteractions(localDataSource);
    });

    test('get random-return correctly data when server return data', () async {
      when(remoteDataSource.getRandomNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);
      final result = await repositoryImpl.getRandomNumberTrivia();
      expect(result, Right(tNumberTriviaModel));
      verify(localDataSource.cacheNumberTrivia(tNumberTriviaModel));
    });

    test('get random-return server failure data when server return exception',
        () async {
      when(remoteDataSource.getRandomNumberTrivia()).thenThrow(Exception());
      final result = await repositoryImpl.getRandomNumberTrivia();
      expect(result, Left(ServerFailure()));
      verifyZeroInteractions(localDataSource);
    });
  });
} 
