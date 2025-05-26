import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStandard extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final Color? fillColor;

  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int maxlines;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;

  const CustomTextStandard({
    super.key,
    this.text = '',
    this.fontSize = 12.0,
    this.color,
    this.fillColor,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.maxlines = 1,
    this.onTap,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    var txt = Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxlines,
    );
    if (onTap != null) return GestureDetector(onTap: onTap, child: txt);
    if (fillColor != null) return Container(padding: EdgeInsets.all(5), color: fillColor, child: txt);
    return txt;
  }
}

class CustomTextAppBar extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const CustomTextAppBar({
    super.key,
    required this.text,
    this.fontSize = 20.0,
    this.color = Colors.white,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}

class TextJudulBody extends StatelessWidget {
  final String text;

  const TextJudulBody({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyLarge);
  }
}

class TextJudulBodyTebal extends StatelessWidget {
  final String text;

  const TextJudulBodyTebal({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold));
  }
}

class TextBodyMedium extends StatelessWidget {
  final String text;

  const TextBodyMedium({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}

class TextBodyMediumTebal extends StatelessWidget {
  final String text;

  const TextBodyMediumTebal({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold));
  }
}
