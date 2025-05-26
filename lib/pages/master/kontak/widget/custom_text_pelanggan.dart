import 'package:flutter/material.dart';
import 'package:ljm/widgets/customtext.dart';

class CTPelanggan extends StatelessWidget {
  final String text1;
  final String text2;
  final Color color1;
  final FontWeight fontWeight2;

  final Color color2;

  const CTPelanggan({
    super.key,
    required this.text1,
    required this.text2,
    this.color1 = Colors.black,
    this.color2 = Colors.black,
    this.fontWeight2 = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: CustomTextStandard(
                text: text1,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                maxlines: 2,
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 2,
              child: CustomTextStandard(
                color: color2,
                text: text2,
                fontWeight: fontWeight2,
                maxlines: 2,
              )),
        ],
      ),
    );
  }
}
