import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_test/utils/exports.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController profileController;
  late Tween<double> containerWidthTween;
  late Tween<double> profileSizeTween;
  bool showLocationText = false;
  bool showName = false;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    profileController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    containerWidthTween = Tween<double>(begin: 0, end: 170);
    profileSizeTween = Tween<double>(begin: 0, end: 25.w);

    controller.forward();
    profileController.forward();

    controller.addListener(() {
      setState(() {});
    });

    profileController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    profileController.dispose();
    super.dispose();
  }

  void startAnimation() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 50.h,
              width: containerWidthTween.evaluate(controller),
              decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              onEnd: () {
                setState(() {});
                showLocationText = true;
              },
              child: AnimatedOpacity(
                opacity: !showLocationText ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                onEnd: () {
                  setState(() {});
                  showName = true;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: appColors.brownA5947D,
                    ),
                    Text(
                      'Saint Petersburg',
                      style: AppTypography.outfitNormal14,
                    )
                  ],
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: appColors.primaryColors,
              radius: profileSizeTween.evaluate(profileController),
              backgroundImage: const AssetImage(
                  'assets/images/header_pic.png'), // Add the image here
            ),
          ],
        ),
        SizedBox(height: 40.h),
        AnimatedOpacity(
          duration: const Duration(
            milliseconds: 300,
          ),
          opacity: !showName ? 0 : 1,
          child: Text(
            'Hi, Marina',
            style: AppTypography.outfitNormal25
                .copyWith(color: appColors.brownA5947D.withOpacity(.9)),
          ),
        ),
        const SizedBox(height: 8),
        AppFadeInAnimation(
          duration: const Duration(milliseconds: 900),
          delayed: const Duration(milliseconds: 1500),
          fadeInType: FadeInType.down,
          child: Text(
            'let\'s select your',
            style: AppTypography.outfitBold24,
          ),
        ),
        AppFadeInAnimation(
          duration: const Duration(milliseconds: 900),
          delayed: const Duration(milliseconds: 1700),
          fadeInType: FadeInType.down,
          child: Text(
            'perfect place',
            style: AppTypography.outfitBold24,
          ),
        ),
      ],
    );
  }
}
