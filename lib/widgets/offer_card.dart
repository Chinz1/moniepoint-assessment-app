import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moniepoint_test/utils/exports.dart';

class OfferCard extends StatefulWidget {
  const OfferCard({
    super.key,
    required this.title,
    required this.count,
    required this.isCircle,
  });

  final String title;
  final String count;
  final bool isCircle;

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _numberController;
  late Animation<int> _numberAnimation;
  late Animation<double> _scaleAnimation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _numberController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _numberAnimation =
        IntTween(begin: 900, end: int.parse(widget.count)).animate(
      CurvedAnimation(parent: _numberController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _timer = Timer(const Duration(seconds: 2), () {
      _controller.forward();
      _numberController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _numberController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedBuilder(
        animation: Listenable.merge([_controller, _numberController]),
        builder: (context, child) {
          double currentScale = _scaleAnimation.value;

          return Transform.scale(
            scale: currentScale,
            child: Container(
              height: 190.h,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color:
                    widget.isCircle ? appColors.primaryColors : appColors.white,
                shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
                borderRadius:
                    widget.isCircle ? null : BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 10.h),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.isCircle
                          ? appColors.white
                          : appColors.brownA5947D,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Flexible(
                    child: Text(
                      _numberAnimation.value.toString(),
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: widget.isCircle
                              ? appColors.white
                              : appColors.brownA5947D,
                          fontWeight: FontWeight.w900,
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'offers',
                    style: TextStyle(
                      color: widget.isCircle
                          ? appColors.white
                          : appColors.brownA5947D,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
