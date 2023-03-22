import 'package:clean_architecture_flutter/data/datasource/number_trivia_local_data_source.dart';
import 'package:clean_architecture_flutter/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter/data/network/NetworkInfo.dart';
import 'package:clean_architecture_flutter/data/repository/NumberTriviaRepositoryImpl.dart';
import 'package:clean_architecture_flutter/domain/model/number_trivia.dart';
import 'package:clean_architecture_flutter/domain/repository/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
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
  late MockNumberTriviaRemoteDataSource remoteDataSource;
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
    final tNumber = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: "Hello");
    setUp(() {
      when(networkInfo.isConnect()).thenAnswer((_) async => true);
      when(remoteDataSource.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTrivia);
    });
    group('get concrete number trivia', () {
      test('should check network before', () async {
        repository.getConcreteNumberTrivia(1);
        verify(networkInfo.isConnect());
      });
      test(
          'should return data from remote data source when call remote success',
          () async {
        final numberTrivia = NumberTrivia(number: 1, text: "hello");
        when(remoteDataSource.getConcreteNumberTrivia(1))
            .thenAnswer((_) async => numberTrivia);
        final result = await repository.getConcreteNumberTrivia(1);
        expect(result, Right(numberTrivia));
      });
      test('should cache to local when call remote succeess', () async {
        await repository.getConcreteNumberTrivia(tNumber);
        verify(localDatasource.cacheNumberTrivia(tNumberTrivia));
      });
      test('shoult return errpr when call remote fail', () async {
        when(remoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenThrow(FlutterError("Remote error"));
        final result = await repository.getConcreteNumberTrivia(1);
        expect(result.isLeft(), true);
      });
    });
  });
}
