import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/providers/static_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyStatefulPage extends ConsumerStatefulWidget {
  const MyStatefulPage({super.key});

  @override
  ConsumerState<MyStatefulPage> createState() => _MyStatefulPageState();
}

class _MyStatefulPageState extends ConsumerState<MyStatefulPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    // init controller listener and listen for changes to update provider state
    _controller.addListener(() {
      ref.read(textProvider.notifier).state = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final text = ref.watch(textProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Text Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Type something',
              ),
            ),
            const SizedBox(height: 20),
            Text('Your typed: $text'),

          Image.asset(
              'assets/images/TBT.jpg',
              fit: BoxFit.cover,
              width: 200,
              height: 400,
            alignment: .center,
            ),

             

          ],
        ),
      ),
    );
  }
}
