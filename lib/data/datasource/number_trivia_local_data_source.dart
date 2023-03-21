import '../../domain/model/number_trivia.dart';

abstract class NumberTriviaLocalDatasource {
  Future<NumberTrivia> getConcreteNumberTrivia(int number);
  Future<NumberTrivia> getRandomNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTrivia numberTrivia);
}
