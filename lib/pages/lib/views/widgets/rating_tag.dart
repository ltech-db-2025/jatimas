import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ljm/tools/env.dart';
import '../../constant/app_color.dart';

class RatingTag extends StatelessWidget {
  final double value;
  final EdgeInsetsGeometry? margin;
  const RatingTag({super.key, required this.value, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      margin: margin,
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 8),
      decoration: BoxDecoration(color: AppColor.secondary, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/Star-active.svg',
            width: 14,
            height: 14,
          ),
          const SizedBox(width: 4),
          Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class TitleTag extends StatelessWidget {
  final double value;
  final EdgeInsetsGeometry? margin;
  const TitleTag({super.key, required this.value, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 8),
      decoration: BoxDecoration(color: AppColor.secondary, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/Star-active.svg',
            width: 14,
            height: 14,
          ),
          const SizedBox(width: 4),
          Text(
            formatangka(value),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
