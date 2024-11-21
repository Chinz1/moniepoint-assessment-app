import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_test/utils/app_colors.dart';
import 'package:moniepoint_test/utils/app_typgraphy.dart';
import 'package:moniepoint_test/widgets/exports.dart';
import 'package:moniepoint_test/widgets/map_options.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final ValueNotifier _showOptions = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // // Black background
          // Container(
          //   color: appColors.mapColor,
          // ),

          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_screen_background.png', // Update with your image path
              fit: BoxFit.cover,
            ),
          ),

          // Search bar
          Positioned(
              top: 70.h,
              left: 30.w,
              right: 30.w,
              child: const MapScreenHeader()),

          // Floating buttons
          Positioned(
            bottom: 120.h,
            left: 30.w,
            child: Column(
              children: [
                FloatingActionButtonWidget(
                  icon: Icons.layers_outlined,
                  onTap: () {
                    _showOptions.value = true;
                  },
                ),
                SizedBox(height: 5.h),
                FloatingActionButtonWidget(
                  icon: Icons.send_sharp,
                  onTap: () {},
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 120.h,
            right: 20.w,
            child: ExtendedFloatingActionButton(
              label: Row(
                children: [
                  Icon(
                    Icons.list,
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
              onTap: () {},
            ),
          ),

          //  markers
          ..._buildMarkers(),
          Positioned(
            left: 30.w,
            bottom: 180.h,
            child: ValueListenableBuilder(
              valueListenable: _showOptions,
              builder: (_, show, __) {
                return MapOptions(
                  show: show,
                  onDismissed: () {
                    _showOptions.value = false;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMarkers() {
    // Sample marker positions with their corresponding texts
    final markerData = [
      {'position': const Offset(100, 200), 'text': '10,3 mn P'},
      {'position': const Offset(120, 265), 'text': '11 mn P'},
      {'position': const Offset(300, 280), 'text': '7,8 mn P'},
      {'position': const Offset(50, 500), 'text': '13,3 mn P'},
      {'position': const Offset(250, 600), 'text': '6,95 mn P'},
      {'position': const Offset(300, 400), 'text': '8,5 mn P'},
    ];

    return markerData.map((data) {
      final position = data['position'] as Offset;
      final text = data['text'] as String;
      return Positioned(
        left: position.dx,
        top: position.dy,
        child: MarkerWidget(text: text),
      );
    }).toList();
  }
}
