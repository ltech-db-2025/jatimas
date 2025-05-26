// ignore_for_file: unnecessary_import

import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class XBarData {
  const XBarData(this.color, this.value, this.shadowValue);
  final Color color;
  final double value;
  final double shadowValue;
}

class XBarData2 {
  const XBarData2(this.bulan, this.omset, this.pelunasan, this.tempo);
  final int bulan;
  final double omset;
  final double pelunasan;
  final double tempo;
}

class XIconWidget extends ImplicitlyAnimatedWidget {
  const XIconWidget({
    super.key,
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<XIconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Icon(
        widget.isSelected ? Icons.face_retouching_natural : Icons.face,
        color: widget.color,
        size: 28,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}
