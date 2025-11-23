
import 'dart:async';
import 'dart:math';

import 'package:hive_ce_flutter/adapters.dart';

class FakeApiService {
  Future<String> fetchGreeting() async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulate a random greeting

    final box =  Hive.box('reading_progress');

    //box.delete("abc");

    int? lastPage = box.get('abc');


    if (lastPage == null) {
      box.put('abc', Random().nextInt(100));
      lastPage = box.get('abc');
    }


    if (Random().nextDouble() > 0.3) {
      throw Exception('Failed to fetch greeting');
    }


    return 'Hello From Async! $lastPage';
  }
}