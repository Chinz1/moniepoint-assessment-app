import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_test/utils/exports.dart';
import 'package:moniepoint_test/widgets/exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffF8F8F8), Color(0xffFAD7AD)],
              stops: [.2, .7],
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h), // To account for status bar height
                    const Header(),

                    SizedBox(height: 40.h),
                    Row(
                      children: [
                        const OfferCard(
                            title: 'BUY', count: '1034', isCircle: true),
                        SizedBox(width: 16.w),
                        const OfferCard(
                            title: 'RENT', count: '2122', isCircle: false),
                      ],
                    ),
                  ],
                ),
              ),

              // Draggable sheet
              AppFadeInAnimation(
                duration: const Duration(seconds: 1),
                delayed: const Duration(seconds: 3),
                fadeInType: FadeInType.down,
                child: DraggableScrollableSheet(
                  maxChildSize: .8,
                  minChildSize: .41,
                  initialChildSize: .42,
                  builder: (context, scrollController) {
                    return Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: appColors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Column(
                          children: [
                            ItemsCard(
                              height: 230.h,
                              radius: 40,
                              asset: icItem,
                              title: 'Gladkava St, 25',
                              titleContainerHeight: 50.h,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ItemsCard(
                                    height: 470.h,
                                    asset: icItem,
                                    title: 'Tufikw St, 25',
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Column(
                                    children: [
                                      ItemsCard(
                                        height: 230.h,
                                        asset: icItem,
                                        title: 'Tufikw St, 25',
                                      ),
                                      SizedBox(height: 8.h),
                                      ItemsCard(
                                        height: 230.h,
                                        asset: icItem,
                                        title: 'Tufikw St, 25',
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // bottom nave
            ],
          ),
        ),
      ),
    );
  }
}
