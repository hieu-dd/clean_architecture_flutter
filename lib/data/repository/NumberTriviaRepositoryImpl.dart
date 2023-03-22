import 'package:clean_architecture_flutter/data/datasource/number_trivia_local_data_source.dart';
import 'package:clean_architecture_flutter/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter/data/network/NetworkInfo.dart';
import 'package:clean_architecture_flutter/domain/model/number_trivia.dart';
import 'package:clean_architecture_flutter/domain/repository/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

import '../../common/error/failure.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NetworkInfo networkInfo;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDatasource localDatasource;

  NumberTriviaRepositoryImpl(
      this.networkInfo, this.localDatasource, this.remoteDataSource);

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return Left(UnImplementError());
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return Left(UnImplementError());
  }
}
