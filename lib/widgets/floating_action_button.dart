import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_test/utils/exports.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleSizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _circleSizeAnimation = Tween<double>(begin: 0, end: 55.h).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onTap.call();
      },
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _circleSizeAnimation.value / 55,
              child: Container(
                height: 55.w,
                width: 55.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColors.fabButtonColor.withOpacity(0.8),
                ),
                child: Icon(
                  widget.icon,
                  color: appColors.white.withOpacity(.5),
                ),
              ),
            );
          }),
    );
  }
}

class ExtendedFloatingActionButton extends StatefulWidget {
  const ExtendedFloatingActionButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final Widget label;
  final VoidCallback onTap;

  @override
  State<ExtendedFloatingActionButton> createState() =>
      _ExtendedFloatingActionButtonState();
}

class _ExtendedFloatingActionButtonState
    extends State<ExtendedFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleSizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _circleSizeAnimation = Tween<double>(begin: 0, end: 55.h).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onTap.call();
      },
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _circleSizeAnimation.value / 55,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: appColors.fabButtonColor.withOpacity(0.8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      // Icons.home_work,
                      // Icons.list,
                      Icons.apartment,
                      color: appColors.white.withOpacity(.7),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'List of variants',
                      style: AppTypography.outfitNormal14.copyWith(
                        color: appColors.white.withOpacity(.7),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}


class FloatingActionButtonWidgetWithImage extends StatefulWidget {
  const FloatingActionButtonWidgetWithImage({
    super.key,
    this.icon,
    this.imageAsset,
    required this.onTap,
  });

  final IconData? icon;
  final String? imageAsset; // Image asset path
  final VoidCallback onTap;

  @override
  State<FloatingActionButtonWidgetWithImage> createState() =>
      _FloatingActionButtonWidgetWithImageState();
}

class _FloatingActionButtonWidgetWithImageState extends State<FloatingActionButtonWidgetWithImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleSizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _circleSizeAnimation = Tween<double>(begin: 0, end: 55.h).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onTap.call();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _circleSizeAnimation.value / 55,
            child: Container(
              height: 55.w,
              width: 55.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appColors.fabButtonColor.withOpacity(0.8),
              ),
              child: widget.imageAsset != null
                  ? Image.asset(
                      widget.imageAsset!,
                      // fit: BoxFit.contain,
                      height: 5.h,
                      width: 5.w,
                    )
                  : Icon(
                      widget.icon,
                      color: appColors.white.withOpacity(.5),
                    ),
            ),
          );
        },
      ),
    );
  }
}
