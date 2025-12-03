import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/pages/greeting_screen.dart';
import 'package:flutter_relearn_provider/pages/my_stateful_page.dart';
import 'package:flutter_relearn_provider/pages/pdf_state_page.dart';
import 'package:get/get.dart';

class NavigationCarousel extends StatefulWidget {
  const NavigationCarousel({super.key});

  @override
  State<NavigationCarousel> createState() => _NavigationCarouselState();
}

class _NavigationCarouselState extends State<NavigationCarousel> {
  late PageController _pageController;
  double _currentPage = 0.0;

  // 1. Add an "image" key to your data map
  final List<Map<String, dynamic>> _carouselItems = [
    {
      "title": "Go to Pdf Page",
      "color": Colors.deepOrange[200]!,
      "image": "assets/images/TBT.jpg", // Image for the first card
      "onTap": () => Get.to(() => const PdfStatePage()),
    },
    {
      "title": "Go to State Page",
      "color": Colors.green[200]!,
      "image": "assets/images/Leadership.jpg", // Image for the second card
      "onTap": () => Get.to(() => const MyStatefulPage()),
    },
    {
      "title": "Go to Greetings Page",
      "color": Colors.amber[200]!,
      "image": "assets/images/SAJ.jpg", // Image for the third card
      "onTap": () => Get.to(() => const GreetingScreen()),
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.4, // Shows adjacent cards
    );
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
    return SizedBox(
      height: 270,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _carouselItems.length,
        itemBuilder: (context, index) {
          // Calculate the scale and elevation for the current item
          double scale = max(0.85, 1 - (_currentPage - index).abs() * 0.3);
          double elevation = (_currentPage.round() == index) ? 8.0 : 4.0;

          final item = _carouselItems[index];
          return Transform.scale(
            scale: scale,
            child: _buildCarouselCard(
              title: item["title"],
              color: item["color"],
              imageAsset: item["image"], // Pass the image asset path
              onTap: item["onTap"],
              elevation: elevation,
            ),
          );
        },
      ),
    );
  }

  // 2. Update the _buildCarouselCard method to accept and use the image
  Widget _buildCarouselCard({
    required String title,
    required Color color,
    required String imageAsset,
    required VoidCallback onTap,
    double elevation = 8.0,
  }) {
    return Padding(
      // Add padding to create space between cards
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: elevation,
          color: color,
          clipBehavior: Clip.hardEdge, // Important to keep the image inside the card's rounded corners
          shadowColor: Theme
              .of(context)
              .brightness == Brightness.dark
              ? Theme
              .of(context)
              .colorScheme
              .onPrimaryContainer// darker shadow in dark mode
              : const Color.fromRGBO(140, 72, 210, 1.0).withOpacity(0.4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          child: Stack( // Use a Stack to layer the image and text
            fit: StackFit.expand,
            children: [
              // 3. Image background with a color overlay for readability
              Ink.image(
                image: AssetImage(imageAsset),
                fit: BoxFit.fill,
                child: InkWell(onTap: onTap), // Makes the image tappable
              ),
              // 4. Gradient overlay to make text more readable
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.3), Colors.transparent, Colors.black.withOpacity(0.3)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // 5. Positioned Text
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Changed text color to white for better contrast
                      shadows: [Shadow(blurRadius: 2, color: Colors.black87)] // Add shadow for readability
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
