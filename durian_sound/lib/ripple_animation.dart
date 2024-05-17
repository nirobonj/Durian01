import 'dart:async';

import 'package:flutter/material.dart';

class RippleAnimation extends StatefulWidget {
  ///initialize the ripple animation
  const RippleAnimation({
    required this.child,
    this.color = Colors.black,
    this.delay = Duration.zero,
    this.repeat = false,
    this.minRadius = 60,
    this.ripplesCount = 5,
    this.duration = const Duration(milliseconds: 2300),
    super.key,
  });

  final Widget child;
  final Duration delay;
  final double minRadius;
  final Color color;
  final int ripplesCount;
  final Duration duration;
  final bool repeat;

  @override
  RippleAnimationState createState() => RippleAnimationState();
}

///state of the animation
class RippleAnimationState extends State<RippleAnimation>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    Timer? animationTimer;

    animationTimer = Timer(widget.delay, () {
      if (_controller != null && mounted) {
        widget.repeat ? _controller!.repeat() : _controller!.forward();
      }
      animationTimer?.cancel();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: CirclePainter(
          _controller,
          color: widget.color,
          minRadius: widget.minRadius,
          wavesCount: widget.ripplesCount + 2,
        ),
        child: widget.child,
      );
}

class CirclePainter extends CustomPainter {
  CirclePainter(
    this.animation, {
    required this.wavesCount,
    required this.color,
    this.minRadius,
  }) : super(repaint: animation);

  final Color color;
  final double? minRadius;
  final int wavesCount;
  final Animation<double>? animation;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    for (int wave = 0; wave <= wavesCount; wave++) {
      circle(
        canvas,
        rect,
        minRadius,
        wave,
        animation!.value,
        wavesCount,
        color,
      );
    }
  }
  void circle(
    Canvas canvas,
    Rect rect,
    double? minRadius,
    int wave,
    double value,
    int? length,
    Color circleColor,
  ) {
    Color color = circleColor;
    double r;
    if (wave != 0) {
      final double opacity =
          (1 - ((wave - 1) / length!) - value).clamp(0.0, 1.0);
      color = color.withOpacity(opacity);

      r = minRadius! * (1 + (wave * value)) * value;
      final Paint paint = Paint()..color = color;
      canvas.drawCircle(rect.center, r, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}
