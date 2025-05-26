import 'package:flutter/material.dart';
import 'package:ljm/tools/env.dart';

class HeaderItem extends StatelessWidget {
  final String divisi;

  const HeaderItem({super.key, required this.divisi});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(divisi),
      tileColor: Colors.grey[200],
    );
  }
}

class SubtotalItem extends StatelessWidget {
  final String divisi;
  final String subtotal;

  const SubtotalItem({super.key, required this.divisi, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(divisi),
      trailing: Text(formatangka(subtotal), style: const TextStyle(fontWeight: FontWeight.bold)),
      tileColor: Colors.grey[300],
    );
  }
}

class GrandTotalItem extends StatelessWidget {
  final String grandTotal;

  const GrandTotalItem({super.key, required this.grandTotal});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Grand Total"),
      trailing: Text(formatangka(grandTotal), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      tileColor: Colors.grey[400],
    );
  }
}
