
import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/widgets/navigation_holder.dart';
import 'package:flutter_relearn_provider/widgets/wotd_holder.dart';
import '../widgets/navigation_carousel.dart';
import '../widgets/welcome_header.dart';


// 1. Convert to a StatefulWidget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              
              const SizedBox(height: 20),
              const WelcomeHeader(),
             // const SizedBox(height: 10),
              const WotdHolderPanel(),
              const SizedBox(height: 20),
              NavigationHolderPanel(),
            ],
          ),
        ),
      ),
    );
  }
}