import 'package:flutter/material.dart';

List<String> getAlphabetsFromStringList(List<String> originalList) {
  List<String> alphabets = [];

  for (String item in originalList) {
    if (!alphabets.contains(item[0])) alphabets.add(item[0]);
  }

  alphabets.sort((a, b) => a.compareTo(b));

  return alphabets;
}

class JenisLayanan extends StatelessWidget {
  final String layanan;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  const JenisLayanan(this.layanan, {this.isSelected = false, required this.onTap, this.onLongPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: MaterialButton(
        onLongPress: onLongPress,
        onPressed: onTap,
        color: isSelected ? Colors.black54 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        child: Text(layanan, style: TextStyle(fontSize: 10, color: isSelected ? Colors.white : Colors.black45)),
      ),
    );
  }
}
