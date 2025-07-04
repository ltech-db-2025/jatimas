import 'package:flutter/material.dart';
import '../../constant/app_color.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final Widget icon;
  final int value;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;

  const CustomIconButtonWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        margin: margin,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: icon,
            ),
            (value != 0)
                ? Container(
                    width: 16,
                    height: 16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColor.accent,
                    ),
                    child: Text(
                      '$value',
                      style: const TextStyle(color: AppColor.secondary, fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
