

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PdfStatePage extends StatefulWidget {
  const PdfStatePage({super.key});

  @override
  State<PdfStatePage> createState() => _PdfStatePageState();
}

class _PdfStatePageState extends State<PdfStatePage> {

  int initialPage = 1;
  int lastReadPage = 0;
  late PdfControllerPinch pdfController;


  @override
  void initState() {
    super.initState();

    // open Hive box
    final box =  Hive.box('reading_progress');
    // get last read page
    int? lastPage = box.get('abc');
    // set the last read page to initial page
    if (lastPage != null) {
       lastReadPage = lastPage;
       initialPage = lastPage;
    }

    pdfController = PdfControllerPinch(
      document: PdfDocument.openData(
         InternetFile.get(
          'https://d2gjf1k2xwgzwd.cloudfront.net/TBT_PDF/English/WM_English_Jesus.pdf'
        )
      ),
      initialPage: initialPage,
    );
  }


  @override
  void dispose() {
    if (kDebugMode) {
      print("On Dispose called $lastReadPage");
    }

    //Save this to the hive box;
     final box =  Hive.box('reading_progress');
     box.put('abc', lastReadPage);

    pdfController.dispose();
    super.dispose();
  }

  // helper function

  void _onPageChanged(int page) {

    if (kDebugMode) {
      print('Page changed: $page');
    }

    lastReadPage = page;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey,
    appBar: AppBar(
      title: const Text('PDF Viewer'),
      actions: [
        IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: ()   {
            pdfController.previousPage(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 100),
            );
          },
        ),
        PdfPageNumber(controller: pdfController,
            builder: (_, loadingState, pageMumber, totalPages) => Container(
              alignment: Alignment.center,
              child: Text('$pageMumber/${totalPages ?? 0}'),
            )
        ),
      ],),
      body: PdfViewPinch(
        controller: pdfController,
        onPageChanged: (page) => _onPageChanged(page),

        scrollDirection: Axis.vertical,
        builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
            options: const DefaultBuilderOptions(),
            documentLoaderBuilder: (_) => const Center(
                child: CircularProgressIndicator()),
            pageLoaderBuilder: (_) => const Center(
                child: CircularProgressIndicator()),
          errorBuilder: (context, error) => Center(
            child: Text(error.toString(), style: const TextStyle(color: Colors.red),),

        ),
      )
      )

  );
}
