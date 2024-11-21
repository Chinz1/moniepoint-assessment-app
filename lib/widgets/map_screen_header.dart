import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_test/utils/exports.dart';

class MapScreenHeader extends StatefulWidget {
  const MapScreenHeader({super.key});

  @override
  State<MapScreenHeader> createState() => _MapScreenHeaderState();
}

class _MapScreenHeaderState extends State<MapScreenHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _headerAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _headerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          children: [
            Expanded(
              child: Transform.scale(
                scale: _headerAnimation.value,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Saint Petersburg',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: appColors.black.withOpacity(.8),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: appColors.black.withOpacity(.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Transform.scale(
              scale: _headerAnimation.value,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Icon(Icons.tune, color: appColors.black.withOpacity(.5)),
              ),
            ),
          ],
        );
      }
    );
  }
}
