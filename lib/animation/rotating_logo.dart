import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatingLogo extends StatefulWidget {
  final String imagePath;
  const RotatingLogo({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<RotatingLogo> createState() => _RotatingLogoState();
}

class _RotatingLogoState extends State<RotatingLogo>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: Container(
          height: 200,
          width: 200,
          child: Center(
            child: Image.asset(widget.imagePath),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _animationController.value * 2.0 * math.pi,
            child: child,
          );
        });
  }
}
