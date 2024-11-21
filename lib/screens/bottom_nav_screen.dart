import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_test/screens/exports.dart';
import 'package:moniepoint_test/utils/exports.dart';
import 'package:moniepoint_test/widgets/exports.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen>
    with SingleTickerProviderStateMixin {
  final screens =  [
    MapScreen(),
    const Placeholder(color: Colors.blue),
     const HomePage(),
   const  Placeholder(color: Colors.red),
    const Placeholder(color: Colors.red),
  ];

  final icons = [
    Icons.search,
    Icons.chat,
    Icons.home,
    Icons.favorite,
    Icons.person,
  ];

  int _selectedIndex = 2;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        _fadeController.forward(from: 0.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FadeTransition(
            opacity: _fadeController.drive(CurveTween(curve: Curves.linear)),
            // child: IndexedStack(
            //   index: _selectedIndex,
            //   children: screens,
            // ),
            child: screens[_selectedIndex],
          ),

          // bottom nav bar
          Align(
            alignment: Alignment.bottomCenter,
            child: AppFadeInAnimation(
              duration: const Duration(milliseconds: 800),
              delayed: const Duration(seconds: 6),
              fadeInType: FadeInType.down,
              child: SizedBox(
                height: 90,
                child: Container(
                  margin: EdgeInsets.only(bottom: 40.h),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    color: appColors.black.withOpacity(.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      icons.length,
                      (index) => BottomNavButton(
                        icon: icons[index],
                        isSelected: _selectedIndex == index,
                        onTap: () => _onItemTapped(index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
