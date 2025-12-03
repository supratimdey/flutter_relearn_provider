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

// This data is now self-contained within the widget
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
height: 250,
child: PageView.builder(
controller: _pageController,
itemCount: _carouselItems.length,
itemBuilder: (context, index) {
// Calculate the scale and elevation for the current item
double scale = max(0.85, 1 - (_currentPage - index).abs() * 0.3);
double elevation = (_currentPage.round() == index) ? 12.0 : 4.0;

          final item = _carouselItems[index];
          return Transform.scale(
            scale: scale,
            child: _buildCarouselCard(
              title: item["title"],
              color: item["color"],
              onTap: item["onTap"],
              elevation: elevation,
            ),
          );
        },
      ),
    );
}

Widget _buildCarouselCard({
required String title,
required Color color,
required VoidCallback onTap,
double elevation = 8.0,
}) {
return SizedBox(
width: 120,
child: GestureDetector(
onTap: onTap,
child: Card(
elevation: elevation,
color: color,
shadowColor: Theme
.of(context)
.brightness == Brightness.dark
? Theme
.of(context)
.colorScheme
.onPrimaryContainer// darker shadow in dark mode
: Color.fromRGBO(140, 72, 210, 1.0).withOpacity(0.4),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15)

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
