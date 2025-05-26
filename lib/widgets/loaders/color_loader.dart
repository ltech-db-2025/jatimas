import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ljm/tools/env.dart';

class ColorLoader extends StatefulWidget {
  final List<Color>? colors;
  final Duration? duration;

  const ColorLoader({super.key, this.colors, this.duration});

  @override
  // ignore: no_logic_in_create_state
  State<ColorLoader> createState() => _ColorLoaderState(colors!, duration!);
}

class _ColorLoaderState extends State<ColorLoader> with SingleTickerProviderStateMixin {
  final List<Color> colors;
  final Duration duration;
  late Timer timer;

  _ColorLoaderState(this.colors, this.duration);

  //noSuchMethod(Invocation i) => super.noSuchMethod(i);

  List<ColorTween> tweenAnimations = [];
  int tweenIndex = 0;

  late AnimationController controller;
  List<Animation<Color?>> colorAnimations = [];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    for (int i = 0; i < colors.length - 1; i++) {
      tweenAnimations.add(ColorTween(begin: colors[i], end: colors[i + 1]));
    }

    tweenAnimations.add(ColorTween(begin: colors[colors.length - 1], end: colors[0]));

    for (int i = 0; i < colors.length; i++) {
      Animation<Color?> animation = tweenAnimations[i].animate(CurvedAnimation(parent: controller, curve: Interval((1 / colors.length) * (i + 1) - 0.05, (1 / colors.length) * (i + 1), curve: Curves.linear)));

      colorAnimations.add(animation);
    }

    dp("${colorAnimations.length}");

    tweenIndex = 0;

    timer = Timer.periodic(duration, (Timer t) {
      setState(() {
        tweenIndex = (tweenIndex + 1) % colors.length;
      });
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 5.0,
        valueColor: colorAnimations[tweenIndex],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }
}
