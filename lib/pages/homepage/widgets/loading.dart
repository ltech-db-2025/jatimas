import 'package:flutter/material.dart';

double containerHeight = 40;
loadingBarangBaruDatang(double mg) => Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      child: Card(
        color: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(height: containerHeight, width: mg * 0.14, color: Colors.grey),
            Container(height: containerHeight, width: mg * 0.5, color: Colors.grey),
            Container(height: containerHeight, width: mg * 0.1, color: Colors.transparent, child: Align(alignment: Alignment.centerRight, child: Container(width: mg * 0.05, color: Colors.grey))),
            Container(height: containerHeight, width: mg * 0.1, color: Colors.transparent, child: Align(alignment: Alignment.centerRight, child: Container(width: mg * 0.04, color: Colors.grey))),
          ],
        ),
      ),
    );
