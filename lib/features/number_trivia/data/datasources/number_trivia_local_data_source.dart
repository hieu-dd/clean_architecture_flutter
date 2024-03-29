import 'dart:convert';

import 'package:clean_architecture_flutter/core/error/exception.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int num);

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}

@Singleton(as: NumberTriviaLocalDataSource)
class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cached = sharedPreferences.getString("CACHED_DATA");
    final Map<String, String> data;
    if (cached == null) {
      data = {'${numberTriviaModel.number}': numberTriviaModel.text};
    } else {
      data = jsonDecode(cached);
      data['${numberTriviaModel.number}'] = numberTriviaModel.text;
    }
    sharedPreferences.setString("CACHED_DATA", json.encode(data));
    return;
  }

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int num) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final cached = sharedPreferences.getString("CACHED_DATA");
    if (cached == null) throw CacheException();
    final String? text = json.decode(cached)[num.toString()];
    if (text == null) throw CacheException();
    return NumberTriviaModel(text: text, number: num);
  }
}
