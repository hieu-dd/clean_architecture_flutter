import 'package:clean_architecture_flutter/domain/model/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  Future<Either<Error, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Error, NumberTrivia>> getRandomNumberTrivia();
}
