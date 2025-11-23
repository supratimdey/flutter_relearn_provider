// import 'package:flutter/material.dart';
// import 'package:flutter_relearn_provider/pages/pdf_state_page.dart';
// import 'package:get/get.dart';
//
// import 'greeting_screen.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body:Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                     onPressed: ()  {
//                   Get.to(PdfStatePage());
//                 },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepOrange[200],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15.0),
//                   child: Text("Go to Pdf Page",
//                     style: TextStyle(fontSize: 24),),
//                 )
//                 ),
//               ),
//           const SizedBox(height: 24),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//                 onPressed: ()  {
//                   Get.to(GreetingScreen());
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.amber[200],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 15.0),
//               child: Text("Go to Greetings Page",
//                 style: TextStyle(fontSize: 24),),
//             )
//             ),
//           ),
//             ]
//         ),
//       )
//     );
//   }
// }
