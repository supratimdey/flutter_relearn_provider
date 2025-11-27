import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class BibleRefViewPage extends StatelessWidget {
final String bibleRef;

BibleRefViewPage({Key? key, required this.bibleRef}) : super(key: key) {}

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
);
//..loadRequest(Uri.parse(url));

@override
Widget build(BuildContext context) {
var bibleRefURL = "";

     

    // split the bibleRef
    final bibleRefSplited = bibleRef.split(' ');

    if (bibleRefSplited.length > 2) {
      final bibleBookRef = "https://www.christianity.com/bible/niv/" +
          bibleRefSplited[0] +
          "-" +
          bibleRefSplited[1] +
          "/";
      final bookChapterParaRef = bibleRefSplited[2].replaceAll(":", "-");
      bibleRefURL = bibleBookRef.trim() + bookChapterParaRef.trim();
    } else {
      final bibleBookRef =
          "https://www.christianity.com/bible/niv/" + bibleRefSplited[0] + "/";
      final bookChapterParaRef = bibleRefSplited[1].replaceAll(":", "-");
      bibleRefURL = bibleBookRef.trim() + bookChapterParaRef.trim();
    }

    controller.loadRequest(Uri.parse(bibleRefURL));
    return Scaffold(
        appBar: AppBar(
            title: const Text("Bible"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 127, 25, 47)),
        body: WebViewWidget(
          controller: controller,
        ));
}
}