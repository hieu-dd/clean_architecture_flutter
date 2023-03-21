import 'package:clean_architecture_flutter/core/error/failure.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../di/injection_container.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

abstract class NumberTriviaState {}

class Empty implements NumberTriviaState {}

class Loading implements NumberTriviaState {}

class Error implements NumberTriviaState {
  final String message;

  Error(this.message);
}

class Loaded implements NumberTriviaState {
  final NumberTrivia numberTrivia;

  Loaded(this.numberTrivia);
}

class NumberTriviaNotifier extends StateNotifier<NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTriviaUseCase;
  final GetRandomNumberTrivia getRandomNumberTriviaUseCase;

  NumberTriviaNotifier(
      {required this.getConcreteNumberTriviaUseCase,
      required this.getRandomNumberTriviaUseCase})
      : super(Empty());

  void getConcreteNumberTrivia(String num) async {
    final number = int.tryParse(num);
    if (number == null || number < 0) state = Error("INVALID_INPUT");
    state = Loading();
    final result = await getConcreteNumberTriviaUseCase(Params(number!));
    result.fold((failure) {
      state = Error(_mapFailureToMessage(failure));
    }, (numberTrivia) {
      state = Loaded(numberTrivia);
    });
  }

  void getRandomNumberTrivia() async {
    state = Loading();
    final result = await getRandomNumberTriviaUseCase(NoParams());
    result.fold((failure) {
      state = Error(_mapFailureToMessage(failure));
    }, (numberTrivia) {
      state = Loaded(numberTrivia);
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
  switch (failure.runtimeType) {
    case ServerFailure:
      return "SERVER_FAILURE_MESSAGE";
    case CacheFailure:
      return "CACHE_FAILURE_MESSAGE";
    default:
      return 'Unexpected Error';
  }
}

final numberTriviaProvider =
    StateNotifierProvider<NumberTriviaNotifier, NumberTriviaState>((ref) {
  return sl<NumberTriviaNotifier>();
});
