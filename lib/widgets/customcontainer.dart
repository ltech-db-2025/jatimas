import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final BoxBorder? border;

  const CustomContainer({
    super.key,
    this.width,
    this.height,
    this.color = Colors.blue,
    this.borderColor = Colors.black, // Default border color
    this.borderRadius = 0.0, // Default border radius
    this.borderWidth = 1.0, // Default border width
    this.child,
    this.padding,
    this.margin,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
          width: 2.0,
        ),
      ),
      child: child,
    );
  }
}
