// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DummySearchWidget2 extends StatelessWidget {
  final Function()? onTap;
  const DummySearchWidget2({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  color: Colors.white,
                  width: 18,
                  height: 18,
                ),
              ),
              Text(
                'Find a product...',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
