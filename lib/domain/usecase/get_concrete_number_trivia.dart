import 'package:clean_architecture_flutter/common/error/failure.dart';
import 'package:clean_architecture_flutter/domain/model/number_trivia.dart';
import 'package:clean_architecture_flutter/domain/repository/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> call(int number) async {
    return Left(UnImplementError());
  }
}
