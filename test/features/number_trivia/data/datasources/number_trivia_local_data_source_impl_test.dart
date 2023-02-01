import 'dart:convert';

import 'package:clean_architecture_flutter/core/error/exception.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'number_trivia_local_data_source_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl dataSource;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getConcreteNumberTrivia', () {
    final tNumberTrivia = NumberTriviaModel.fromJson({
      "text": "test2",
      "number": 2,
    });
    test('should return correctly concrete number when cached', () async {
      final Map<String, String> cached = {'1': 'test1', '2': 'test2'};
      when(mockSharedPreferences.getString(any))
          .thenReturn(json.encode(cached));
      final result = await dataSource.getConcreteNumberTrivia(2);
      expect(result, equals(tNumberTrivia));
    });
    test('should throw CacheException when not find data', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final call = await dataSource.getConcreteNumberTrivia;
      expect(call(1), throwsA(TypeMatcher<CacheException>()));
    });
  });

  test('should call SharedPreferences cache data', () async {
    when(mockSharedPreferences.getString(any)).thenReturn(null);
    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((_) async => true);

    final tNumberTrivia = NumberTriviaModel(text: "hihi", number: 1);
    await dataSource.cacheNumberTrivia(tNumberTrivia);
    verify(mockSharedPreferences.setString(
        "CACHED_DATA", json.encode({'1': 'hihi'})));
  });
}
