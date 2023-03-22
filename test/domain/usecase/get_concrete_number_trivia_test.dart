import 'package:clean_architecture_flutter/common/error/failure.dart';
import 'package:clean_architecture_flutter/domain/model/number_trivia.dart';
import 'package:clean_architecture_flutter/domain/repository/number_trivia_repository.dart';
import 'package:clean_architecture_flutter/domain/usecase/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetConcreteNumberTrivia usecase;
  late NumberTriviaRepository repository;
  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(repository);
  });

  test('should get concrete number trivia from repository', () async {
    final numberTrivia = NumberTrivia(number: 1, text: "hello");
    when(repository.getConcreteNumberTrivia(1))
        .thenAnswer((_) async => Right(numberTrivia));
    final result = await usecase(1);
    expect(result, Left(UnImplementError()));
  });
}
