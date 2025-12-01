
import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/pages/new.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light, // Explicitly set brightness
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // 2. Add a corresponding darkTheme
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Explicitly set brightness
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark, // Important for correct color generation
        ),
        useMaterial3: true,
      ),

      // 3. Tell Flutter to follow the system's setting
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
