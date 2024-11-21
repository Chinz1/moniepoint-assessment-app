import 'dart:async';

import 'package:flutter/material.dart';

enum FadeInType {
  right,
  left,
  down,
  top;
}

class AppFadeInAnimation extends StatefulWidget {
  const AppFadeInAnimation({
    super.key,
    required this.child,
    required this.fadeInType,
    required this.duration,
    this.curve = Curves.easeOut,
    this.delayed = const Duration(milliseconds: 0),
  });

  final Widget child;
  final FadeInType fadeInType;
  final Duration delayed;
  final Duration duration;
  final Curve curve;

  @override
  State<AppFadeInAnimation> createState() => _AppFadeInAnimationState();
}

class _AppFadeInAnimationState extends State<AppFadeInAnimation>
    with TickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Define the initial offset based on the fade-in direction
    Offset beginOffset;
    switch (widget.fadeInType) {
      case FadeInType.left:
        beginOffset = const Offset(-1, 0);
        break;
      case FadeInType.right:
        beginOffset = const Offset(1, 0);
        break;
      case FadeInType.top:
        beginOffset = const Offset(0, -1);
        break;
      case FadeInType.down:
        beginOffset = const Offset(0, 1);
        break;
    }

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(curvedAnimation);

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _timer = Timer(widget.delayed, () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _offsetAnimation,
            child: widget.child,
          ),
        );
      },
    );
  }
}
