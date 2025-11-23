import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/providers/static_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    print("Build method loaded");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(CounterProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final counter = ref.watch(CounterProvider);
            return Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
      ),
    );
  }
}
