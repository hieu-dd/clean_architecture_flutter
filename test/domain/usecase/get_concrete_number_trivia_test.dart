import 'package:clean_architecture_flutter/domain/repository/number_trivia_repository.dart';
import 'package:clean_architecture_flutter/domain/usecase/get_concrete_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetConcreteNumberTrivia usecase;
  late NumberTriviaRepository repository;
  setUp(() {});
}
