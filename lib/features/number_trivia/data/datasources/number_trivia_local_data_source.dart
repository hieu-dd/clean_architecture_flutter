import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int num);

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}
