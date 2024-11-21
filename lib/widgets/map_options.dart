import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_test/utils/exports.dart';

class MapOptions extends StatefulWidget {
  const MapOptions({
    super.key,
    required this.show,
    required this.onDismissed,
  });

  final bool show;
  final VoidCallback onDismissed;

  @override
  State<MapOptions> createState() => _MapOptionsState();
}

class _MapOptionsState extends State<MapOptions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation optionAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    optionAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    if (widget.show) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.show) {
      print('1111111');
      _controller.forward();
    } else {
        print('222222');
      _controller.reverse();
    }
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: optionAnimation.value,
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: appColors.whiteFBF5EB,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Tile(
                    title: 'Cosy areas',
                    icon: Icons.shield_outlined,
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      widget.onDismissed.call();
                    },
                  ),
                  SizedBox(height: 20.h),
                  _Tile(
                    title: 'Price',
                    icon: Icons.wallet_outlined,
                    isPrice: true,
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      widget.onDismissed.call();
                    },
                  ),
                  SizedBox(height: 20.h),
                  _Tile(
                    title: 'Infrasture',
                    icon: Icons.house_outlined,
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      widget.onDismissed.call();
                    },
                  ),
                  SizedBox(height: 20.h),
                  _Tile(
                    title: 'Without any layer',
                    icon: Icons.layers_outlined,
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      widget.onDismissed.call();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class _Tile extends StatelessWidget {
  const _Tile(
      {required this.title,
      required this.icon,
      required this.onTap,
      this.isPrice = false});
  final String title;
  final IconData icon;
  final bool isPrice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap.call();
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: isPrice
                ? appColors.primaryColors
                : Colors.black.withOpacity(.4),
          ),
          SizedBox(width: 6.w),
          Text(
            title,
            style: AppTypography.outfitNormal14.copyWith(
                color: isPrice
                    ? appColors.primaryColors
                    : Colors.black.withOpacity(.4),
                fontSize: 15.sp),
          ),
        ],
      ),
    );
  }
}
