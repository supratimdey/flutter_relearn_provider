
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/framework.dart';

import '../providers/static_providers.dart';

class GreetingScreen extends ConsumerWidget{
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final greetingAsync = ref.watch(greetingFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Greeting Screen')),
    body: RefreshIndicator(
      onRefresh: () => ref.refresh(greetingFutureProvider as Refreshable<Future<void>>),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
        /// load data
          child: greetingAsync.when(
            data: (greeting) =>  Column(
              mainAxisSize : MainAxisSize.max,
              children: [
                Text( greeting, style: const TextStyle(fontSize: 24,color: Colors.green)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => ref.refresh(greetingFutureProvider),
                  child: const Text("Retry"),
                )
              ],
            ),
        
           error: (error, stackTrace) => Column(
             mainAxisSize : MainAxisSize.min,
             children: [
               Text('Error: $error', style: const TextStyle(fontSize: 24,color: Colors.red)),
               const SizedBox(height: 12),
               ElevatedButton(
                 onPressed: () => ref.refresh(greetingFutureProvider),
                 child: const Text("Retry"),
               )
             ],
           ),
            loading:  () => const CircularProgressIndicator(),
          ),
        ),
      ),
    ),
    );
  }


}