import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_test/utils/exports.dart';

class MarkerWidget extends StatefulWidget {
  const MarkerWidget({super.key, required this.text});

  final String text;

  @override
  State<MarkerWidget> createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _markerAnimation;

  bool _isShrinking = false; // Flag to track shrinking state
  late Timer _shrinkTimer;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _markerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    // Start the expansion animation
    Timer(const Duration(milliseconds: 1000), () {
      _controller.forward();

      // After 3 seconds, start shrinking
      _shrinkTimer = Timer(const Duration(seconds: 3), () {
        setState(() {
          _isShrinking = true;
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _shrinkTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(15);

    // Adjust width dynamically based on shrinking state
    final double targetWidth = _isShrinking ? (100.w / 2) : 100.w;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _markerAnimation.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut, // Smooth animation curve
            width: targetWidth,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: appColors.primaryColors,
              borderRadius: const BorderRadius.only(
                topLeft: radius,
                topRight: radius,
                bottomRight: radius,
              ),
            ),
            alignment: Alignment.center,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 700),
              opacity: _controller.isCompleted ? 1 : 0,
              child: _isShrinking
                  ? Image.asset(
                      'assets/images/markers_pic.png', // Path to your image
                      height: 25.h,
                      width: 25.w,
                    )
                  : Text(
                      widget.text,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
