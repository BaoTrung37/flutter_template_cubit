import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  late final PageController _pageController;
  final int _totalPages = 3;

  double get _currentOffset {
    final indited = _pageController.hasClients &&
        _pageController.position.hasContentDimensions;
    return indited ? _pageController.page! : _pageController.initialPage * 1.0;
  }

  int get _currentIndex => _currentOffset.round() % _totalPages;
  @override
  void initState() {
    _pageController = PageController(initialPage: 10000, viewportFraction: 0.8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 372.h,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          return _buildCarouselSliderItem(index);
        },
      ),
    );
  }

  Widget _buildCarouselSliderItem(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        var value = _currentOffset - index;
        value = (value * 0.03).clamp(-1, 1);

        var value2 = _currentOffset - index;
        value2 = (value2 * 100).clamp(-100, 100);

        var value3 = _currentOffset - index;
        value3 = (1 - (value3.abs() * 0.3)).clamp(0.8, 1.0);
        return Transform.rotate(
          angle: value * -pi,
          child: Transform.scale(
            scale: value3,
            child: Transform.translate(
              offset: Offset(value2, 0),
              child: child,
            ),
          ),
        );
      },
      child: Container(
        width: 288.w,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
