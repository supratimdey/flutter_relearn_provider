import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/models/pexel_image_data.dart';
import 'package:flutter_relearn_provider/services/pexels_service.dart';
import 'package:flutter_relearn_provider/utils/utility.dart';
import 'package:flutter_relearn_provider/widgets/wotd_card.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/constant_colors.dart';
import '../pages/bible/bible_view_page.dart';

class WotdHolderPanel extends StatefulWidget {
  const WotdHolderPanel();

  @override
  State<WotdHolderPanel> createState() => _WotdHolderPanelState();
}

class _WotdHolderPanelState extends State<WotdHolderPanel> {

 PexelImageData? imageData;
   String? imageUrl;
   late String avgColor ="#FFFFFF";
   

  // 3. Fetch data within the widget's own initState
  @override
  void initState() {
    super.initState();
   // loadData();
  }

  void loadData() {
   // loadImageUrl();
  }

   void loadImageUrl() async {
    final imageData = await PexelsService.getTodayImage();
    if (mounted) {
      setState(() {
        if (imageData != null) {
          imageUrl = imageData.imageUrl;
          avgColor = imageData.avgColor;
        } else {
          // Fallback to a default image URL if none is fetched
          imageUrl =
              'https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg';
          avgColor = '#FFFFFF';
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    debugPrint("Votd Holder Build  method called");

    final ConstantColors constantColors = ConstantColors();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 0.0, right: 10.0),
      //EdgeInsets.only(left: 16.0, right: 16.0),

      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ?   Colors.grey[300]  // darker shadow in dark mode
              : Colors.white,                  // light mode

          borderRadius: BorderRadius.circular(12),

          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.onPrimaryContainer   // darker shadow in dark mode
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
                  const EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 84.0),
                  child: Text(
                    'Verse Of the Day',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.deepPurple  // darker shadow in dark mode
                            : constantColors.purpleColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.book, color: Colors.deepPurple),
                ),
              ],
            ),
            WotdCard(),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: actionBar(context),
            )
          ],
        ),
      ),
    );
  }

// ─────────────────────────────────────────────
  Widget frostedVerseHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  'Verse Of the Day',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.book, color: Colors.deepPurple),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              // ───────────────────────────────────────────────
              // 📖 BIBLE RESOURCES BUTTON  
              // ───────────────────────────────────────────────
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => BibleViewPage());
                  },
                  icon: const Icon(Icons.menu_book_rounded, color: Colors.white),
                  label: Text(
                    "Bible Resources",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: const Color(0xFF542AE2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // ───────────────────────────────────────────────
              // ⛪ UNITY SERVICE BUTTON
              // ───────────────────────────────────────────────
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await _checkAndLaunchUrl();  // keeps your existing logic
                  },
                  icon: const Icon(Icons.church_rounded, color: Colors.white),
                  label: Text(
                    "Unity Service",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: const Color(0xFF542AE2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkAndLaunchUrl() async {
    const urlString = 'https://m.youtube.com/@ServeNowSriLanka';
    if (await canLaunchUrlString(urlString)) {
      await launchUrlString(urlString);
    } else {
      // Handle the case where the URL cannot be launched
      print('Could not launch $urlString');
    }
  }
}