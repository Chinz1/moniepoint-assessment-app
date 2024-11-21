import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_test/utils/exports.dart';

class ItemsCard extends StatefulWidget {
  const ItemsCard({
    super.key,
    required this.height,
    required this.asset,
    required this.title,
    this.radius,
    this.titleContainerHeight,
  });

  final double height;
  final String asset;
  final String title;
  final double? radius;
  final double? titleContainerHeight;

  @override
  State<ItemsCard> createState() => _ItemsCardState();
}

class _ItemsCardState extends State<ItemsCard> with TickerProviderStateMixin {
  late final AnimationController _circleController;
  late final AnimationController _containerController;
  late final AnimationController _textOpacityController;
  late final Animation<double> _circleSizeAnimation;
  late final Animation<double> _containerWidthAnimation;
  late final Animation<double> _containerHeightAnimation;
  late final Animation<Color?> _colorAnimation;
  late final Animation<double> _textOpacityAnimation;
  late final Animation<double> _iconSizeAnimation;
  late final Timer _timer;

  bool _showText = false;

  @override
  void initState() {
    super.initState();

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _containerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _textOpacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _circleSizeAnimation = Tween<double>(begin: 0, end: 25).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeInOut),
    );

    _containerWidthAnimation = Tween<double>(begin: 0.12, end: 1).animate(
      CurvedAnimation(parent: _containerController, curve: Curves.easeOutBack),
    );

    _containerHeightAnimation =
        Tween<double>(begin: 0, end: widget.titleContainerHeight ?? 45).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.white.withOpacity(.5),
    ).animate(
        CurvedAnimation(parent: _circleController, curve: Curves.easeInOut));

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textOpacityController, curve: Curves.easeInOut),
    );

    _iconSizeAnimation = Tween<double>(begin: 0, end: 17).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeInOut),
    );

    _timer = Timer(const Duration(milliseconds: 4000), () {
      _circleController.forward().then((_) {
        _containerController.forward();
        _textOpacityController.forward();

        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            setState(() {
              _showText = true;
            });
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _circleController.dispose();
    _containerController.dispose();
    _textOpacityController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(
        bottom: 15.h,
        left: 15.w,
        right: 15.w,
      ),
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? 20),
        color: Colors.amber,
        image: DecorationImage(
          image: AssetImage(widget.asset),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _circleController,
              _containerController,
              _textOpacityController,
            ]),
            builder: (context, child) {
              return Container(
                alignment: Alignment.center,
                // padding: _circleController.isCompleted
                //     ? EdgeInsets.only(left: 10.w)
                //     : null,
                color: _colorAnimation.value,
                height: _containerHeightAnimation.value.h,
                width: _circleController.isAnimating
                    ? _circleSizeAnimation.value * 2
                    : _containerWidthAnimation.value * size.width,
                child: Row(
                  mainAxisAlignment: _circleController.isAnimating
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
                  children: [
                    if (widget.titleContainerHeight != null && _showText)
                      SizedBox(width: size.width * .3),
                    if (_showText)
                      Opacity(
                        opacity: _textOpacityAnimation.value,
                        child: Text(
                          widget.title,
                          style: AppTypography.outfitNormal17,
                        ),
                      ),
                    if (_showText) const Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: _circleSizeAnimation.value,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: _iconSizeAnimation.value,
                          color: appColors.brownA5947D,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
