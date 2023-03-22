import 'package:clean_architecture_flutter/data/datasource/number_trivia_local_data_source.dart';
import 'package:clean_architecture_flutter/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter/data/network/NetworkInfo.dart';
import 'package:clean_architecture_flutter/domain/model/number_trivia.dart';
import 'package:clean_architecture_flutter/domain/repository/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NetworkInfo networkInfo;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDatasource localDatasource;

  NumberTriviaRepositoryImpl(
      this.networkInfo, this.localDatasource, this.remoteDataSource);

  @override
  Future<Either<Error, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return _getNumberTrivia(
        () async => remoteDataSource.getConcreteNumberTrivia(number),
        () async => localDatasource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Error, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }

  Future<Either<Error, NumberTrivia>> _getNumberTrivia(
      Future<NumberTrivia> Function() getRemoteNumberTrivia,
      Future<NumberTrivia> Function() getLocalNumberTrivia) async {
    try {
      networkInfo.isConnect();
      final result = await getRemoteNumberTrivia.call();
      localDatasource.cacheNumberTrivia(result);
      return Right(result);
    } on Error catch (e) {
      return Left(e);
    }
  }
}
