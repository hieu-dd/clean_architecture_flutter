import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int num);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}
