import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/pages/my_stateful_page.dart';
import 'package:flutter_relearn_provider/pages/pdf_state_page.dart';
import 'package:flutter_relearn_provider/widgets/wotd_holder.dart';
import 'package:get/get.dart';

import 'greeting_screen.dart';

// 1. Convert to a StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 2. Create a PageController and a state variable for the current page
  late PageController _pageController;
  double _currentPage = 0.0;
  final List<Map<String, dynamic>> _carouselItems = [
    {
      "title": "Go to Pdf Page",
      "color": Colors.deepOrange[200]!,
      "onTap": () => Get.to(() => const PdfStatePage()),
    },
    {
      "title": "Go to State Page",
      "color": Colors.green[200]!,
      "onTap": () => Get.to(() => const MyStatefulPage()),
    },
    {
      "title": "Go to Greetings Page",
      "color": Colors.amber[200]!,
      "onTap": () => Get.to(() => const GreetingScreen()),
    },
  ];

  @override
  void initState() {
    super.initState();
    // 3. Initialize the PageController
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.6, // Shows adjacent cards
    );
    // 4. Add a listener to update the current page value on scroll
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const WotdHolderPanel(),
              const SizedBox(height: 40),
              // 5. Replace the ListView with a PageView
              SizedBox(
                height: 240,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _carouselItems.length,
                  itemBuilder: (context, index) {
                    // 6. Calculate the scale and elevation for the current item
                    double scale = max(
                        0.85, 1 - (_currentPage - index).abs() * 0.3);
                    double elevation = (_currentPage.round() == index)
                        ? 12.0
                        : 4.0;

                    final item = _carouselItems[index];
                    return Transform.scale(
                      scale: scale,
                      child: _buildCarouselCard(
                        title: item["title"],
                        color: item["color"],
                        onTap: item["onTap"],
                        elevation: elevation, // Pass the dynamic elevation
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 7. Update the helper method to accept elevation
  Widget _buildCarouselCard({
    required String title,
    required Color color,
    required VoidCallback onTap,
    double elevation = 8.0, // Default elevation
  }) {
    return SizedBox(
      width: 180,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: elevation, // Use the dynamic elevation
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