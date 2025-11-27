import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderLine extends StatelessWidget {
  const HeaderLine({super.key, required this.headerText});

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text("$headerText",
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }
}
