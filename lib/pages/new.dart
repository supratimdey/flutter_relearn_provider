import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/pages/my_stateful_page.dart';
import 'package:flutter_relearn_provider/pages/pdf_state_page.dart';

import 'package:get/get.dart';

import 'greeting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Helper method to build a card for the carousel
  Widget _buildCarouselCard({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 180, // Define a width for each card
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 8.0,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: SizedBox(
                height: 240, // Define a height for the horizontal list
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  // Add padding for the list itself
                  children: [
                    _buildCarouselCard(
                      title: "Go to Pdf Page",
                      color: Colors.deepOrange[200]!,
                      onTap: () {
                        // Using a callback for Get.to is recommended
                        Get.to(() => const PdfStatePage());
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildCarouselCard(
                      title: "Go to State Page",
                      color: Colors.green[200]!,
                      onTap: () {
                        // Using a callback for Get.to is recommended
                        Get.to(() => const MyStatefulPage());
                      },
                    ),
                    const SizedBox(width: 16), // Spacing between cards
                    _buildCarouselCard(
                      title: "Go to Greetings Page",
                      color: Colors.amber[200]!,
                      onTap: () {
                        Get.to(() => const GreetingScreen());
                      },
                    ),
                    // You can easily add more cards here in the future
                  ],
                ),
              ),
            )));
  }
}
