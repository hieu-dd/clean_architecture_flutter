import 'dart:convert';

import 'package:clean_architecture_flutter/core/error/exception.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late NumberTriviaRemoteDataSourceImpl dataSourceImpl;

  void setUpMockHttpClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async =>
          http.Response(json.encode({'text': 'test', 'number': 1}), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  setUp(() {
    mockClient = MockClient();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(client: mockClient);
  });

  group('get Concrete number from remote', () {
    const tNumber = 1;
    test('should return number trivia when server success', () async {
      setUpMockHttpClientSuccess200();
      final result = await dataSourceImpl.getConcreteNumberTrivia(1);
      verify(mockClient.get(
        Uri.parse('http://numbersapi.com/$tNumber'),
        headers: {'Content-Type': 'application/json'},
      ));
      expect(result, equals(NumberTriviaModel(text: 'test', number: 1)));
    });
    test('should throw ServerException when status code != 200', () async {
      setUpMockHttpClientFailure404();
      final call = dataSourceImpl.getConcreteNumberTrivia;
      expect(call(1), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
