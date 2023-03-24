import 'package:clean_architecture_flutter/common/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../model/number_trivia.dart';
import '../repository/number_trivia_repository.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> call(int number) async {
    return Left(UnImplementError());
  }
}
