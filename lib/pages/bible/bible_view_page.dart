import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BibleViewPage extends StatelessWidget {
  BibleViewPage({Key? key}) : super(key: key);

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://www.bible.com/en-GB/bible/111/JHN.1.NIV'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bible"),
          centerTitle: true,
        ),
        body: WebViewWidget(controller: controller,
        ));
  }
}