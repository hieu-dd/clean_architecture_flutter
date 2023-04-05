import 'package:clean_architecture_flutter/core/usecase/usecase.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../repositories/number_trivia_repository.dart';

@Singleton()
class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository _repository;
  GetRandomNumberTrivia(this._repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await _repository.getRandomNumberTrivia();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [true];
}
