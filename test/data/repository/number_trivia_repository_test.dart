import 'package:clean_architecture_flutter/data/datasource/number_trivia_local_data_source.dart';
import 'package:clean_architecture_flutter/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter/data/network/NetworkInfo.dart';
import 'package:clean_architecture_flutter/domain/repository/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'number_trivia_repository_test.mocks.dart';

@GenerateMocks(
    [NumberTriviaRemoteDataSource, NumberTriviaLocalDatasource, NetworkInfo])
void main() {
  late NumberTriviaRepository repository;
  late NetworkInfo networkInfo;
  late NumberTriviaLocalDatasource localDatasource;
  late MockNumberTriviaRemoteDataSource remoteDataSource;
  setUp(() {});
}
