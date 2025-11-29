import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_relearn_provider/models/daily_verse.dart';
import 'package:flutter_relearn_provider/pages/bible/bible_ref_view_page.dart';
import 'package:flutter_relearn_provider/services/pexels_service.dart';
import 'package:flutter_relearn_provider/services/wotd_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. Convert to a StatefulWidget
class WotdCard extends StatefulWidget {
  const WotdCard({super.key});

  @override
  State<WotdCard> createState() => _WotdCardState();
}

class _WotdCardState extends State<WotdCard> {
  // 2. The widget now manages its own state
  String? imageUrl;
  DailyVerse? verse;

  // 3. Fetch data within the widget's own initState
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    loadImageUrl();
    loadVerse();
  }

  void loadVerse() async {
    final fetchedVerse = await WordOfTheDayService.fetchDailyVerse();
    if (mounted) {
      if (fetchedVerse != null) {
        setState(() => verse = fetchedVerse);
      } else {
        // Handle the case where verse is null with a default
        var defaultVerse = DailyVerse(
          text:
          "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.",
          reference: "John 3:16",
        );
        setState(() => verse = defaultVerse);
      }
    }
  }

  void loadImageUrl() async {
    final url = await PexelsService.getTodayImage();
    if (mounted) {
      setState(() => imageUrl = url);
    }
  }

  // 4. The build method remains the same, but now uses its own state
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 240,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: ClipRRect(
              borderRadius: BorderRadius .only(
                  topLeft: Radius.zero,
                  topRight:Radius.zero,
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // --- Background Image ---
                  if (imageUrl != null)
                    CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    )
                  else
                    const Center(child: CircularProgressIndicator()),

                  // --- Text Overlay ---
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (verse != null)
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => BibleRefViewPage(
                                      bibleRef: verse!.reference));
                                },
                                child: Text(
                                  verse!.text.length > 200
                                      ? '${verse!.text.substring(0, 200)}...'
                                      : verse!.text.substring(0),
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            else
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              ),
                            const SizedBox(height: 8),
                            if (verse != null)
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${verse!.reference} ",
                                      style: GoogleFonts.inter(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.open_in_new,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
