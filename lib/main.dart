import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/App/my_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart'; // makes init easier

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive CE for Flutter

  await Hive.initFlutter();

  // Open the box we'll use for reading progress (stores int values)
  await Hive.openBox('reading_progress');

  runApp(ProviderScope(child: const MyApp()));
}




