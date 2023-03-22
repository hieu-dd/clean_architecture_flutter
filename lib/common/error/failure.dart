import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String message;

  Failure({this.message = ""});

  @override
  List<Object?> get props => [message];
}

class RemoteError extends Failure {}

class CachedError extends Failure {}

class UnExpectedError extends Failure {}
