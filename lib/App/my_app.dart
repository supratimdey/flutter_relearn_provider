
import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/pages/home_screen.dart';
import 'package:flutter_relearn_provider/pages/my_home_page.dart';
import 'package:flutter_relearn_provider/pages/my_stateful_page.dart';
import 'package:flutter_relearn_provider/pages/new.dart';
import 'package:flutter_relearn_provider/pages/pdf_state_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../pages/greeting_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HomeScreen(),
    );
  }
}
