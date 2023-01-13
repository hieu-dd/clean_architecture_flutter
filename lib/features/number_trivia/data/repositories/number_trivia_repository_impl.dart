import 'package:clean_architecture_flutter/core/error/failure.dart';
import 'package:clean_architecture_flutter/core/network/network_info.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  NumberTriviaLocalDataSource localDataSource;
  NumberTriviaRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    if (networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.getConcreteNumberTrivia(number);
        localDataSource.cacheNumberTrivia(result);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final result = await localDataSource.getConcreteNumberTrivia(number);
        return Right(result);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    if (networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.getRandomNumberTrivia();
        localDataSource.cacheNumberTrivia(result);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
