import 'package:clean_architecture_flutter/features/number_trivia/presentation/statemanagement/number_trivia_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberTriviaPage extends ConsumerWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NumberTriviaState state = ref.watch(numberTriviaProvider);
    // NumberTriviaState state = Empty();

    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: Column(
        children: [
          Text("Random"),
          state is Empty
              ? Container()
              : state is Loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state is Error
                      ? Center(
                          child: Text(state.message),
                        )
                      : Center(
                          child: Text((state as Error).message),
                        )
        ],
      ),
    );
  }
}
