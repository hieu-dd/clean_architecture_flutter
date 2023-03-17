import 'package:clean_architecture_flutter/features/number_trivia/presentation/statemanagement/number_trivia_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberTriviaPage extends ConsumerWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NumberTriviaState state = ref.watch(numberTriviaProvider);
    // NumberTriviaState state = Empty();
    final numberController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            child: state is Empty
                ? Container()
                : state is Loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is Error
                        ? Center(
                            child: Text(state.message),
                          )
                        : loadedWidget(state as Loaded),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: numberController,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).focusColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).dividerColor, width: 1.0),
                ),
                hintText: 'Mobile Number',
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      final number = int.tryParse(numberController.text);
                      if (number == null) return;
                      ref
                          .read(numberTriviaProvider.notifier)
                          .getConcreteNumberTrivia(numberController.text);
                    },
                    child: Text("Search")),
                flex: 1,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(numberTriviaProvider.notifier)
                          .getRandomNumberTrivia();
                    },
                    child: Text("Random")),
                flex: 1,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget loadedWidget(Loaded data) {
  return Column(
    children: [
      const SizedBox(
        height: 25,
      ),
      Text(
        data.numberTrivia.number.toString(),
        style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          data.numberTrivia.text,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}
