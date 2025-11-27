import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/pages/my_stateful_page.dart';
import 'package:flutter_relearn_provider/pages/pdf_state_page.dart';
import 'package:get/get.dart';
import '../widgets/wotd_card.dart'; // 1. Import the new widget
import 'greeting_screen.dart';

class HomeScreen extends StatelessWidget { // Can now be a StatelessWidget
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 80),

            // 2. Use the self-contained Word of the day Card
            const WotdCard(),

            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildCarouselCard(
                      title: "Go to Pdf Page",
                      color: Colors.deepOrange[200]!,
                      onTap: () {
                        Get.to(() => const PdfStatePage());
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildCarouselCard(
                      title: "Go to State Page",
                      color: Colors.green[200]!,
                      onTap: () {
                        Get.to(() => const MyStatefulPage());
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildCarouselCard(
                      title: "Go to Greetings Page",
                      color: Colors.amber[200]!,
                      onTap: () {
                        Get.to(() => const GreetingScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // This helper method can stay or be moved if you prefer
  Widget _buildCarouselCard({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 180,
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
}
