import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moniepoint_test/utils/app_colors.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          onTap.call();
        },
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.black,
        highlightColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? appColors.primaryColors : Colors.transparent,
          ),
          child: Icon(
            icon,
            color: Colors
                .white, // Replace with appColors.white if defined in your app
          ),
        ),
      ),
    );
  }
}
