

import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/widgets/navigation_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constant_colors.dart';


class NavigationHolderPanel extends StatelessWidget {
  const NavigationHolderPanel({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Navigation Holder Build  method called");

    final ConstantColors constantColors = ConstantColors();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 0.0, right: 10.0),


      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .brightness == Brightness.dark
              ? Colors.grey[900] // darker shadow in dark mode
              : Colors.white54, // light mode

          borderRadius: BorderRadius.circular(12),

          boxShadow: [
            BoxShadow(
              color: Theme
                  .of(context)
                  .brightness == Brightness.dark
                  ? Theme
                  .of(context)
                  .colorScheme
                  .onSecondary// darker shadow in dark mode
                  : Color.fromRGBO(143, 148, 255, 1).withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  frostedVerseHeader(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(
                      left: 4.0, top: 8.0, bottom: 8.0, right: 84.0),
                  child: Text(
                    'Browse',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
                            ? Colors.deepPurple[200]  // darker shadow in dark mode
                            : const Color(0xFF542AE2)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.browse_gallery, color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Colors.deepPurple[200]  // darker shadow in dark mode
                      : const Color(0xFF542AE2)),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            NavigationCarousel(),
          ],
        ),
      ),
    );
  }
}