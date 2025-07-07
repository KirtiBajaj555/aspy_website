import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '/constant/color.dart';
import '/screen/widget/text_transform.dart';
import '/screen/widget/text_reveal.dart';

class FirstSection extends StatefulWidget {
  const FirstSection({super.key});

  @override
  State<FirstSection> createState() => _FirstSectionState();
}

class _FirstSectionState extends State<FirstSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> textRevealAnimation;
  late final Animation<double> textOpacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );

    textRevealAnimation = Tween<double>(begin: 60.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
      ),
    );

    textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      color: AppColors.scaffoldColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.w : 90.w,
        vertical: isMobile ? 40.h : 150.h,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TextColumn(
                  controller: controller,
                  textRevealAnimation: textRevealAnimation,
                  textOpacityAnimation: textOpacityAnimation,
                ),
                SizedBox(height: 30.h),
                SizedBox(height: 400.h, child: const FirstPageImage()),
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 5,
                  child: _TextColumn(
                    controller: controller,
                    textRevealAnimation: textRevealAnimation,
                    textOpacityAnimation: textOpacityAnimation,
                  ),
                ),
                const Expanded(flex: 7, child: FirstPageImage()),
              ],
            ),
    );
  }
}

class _TextColumn extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> textRevealAnimation;
  final Animation<double> textOpacityAnimation;

  const _TextColumn({
    required this.controller,
    required this.textRevealAnimation,
    required this.textOpacityAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final headingFontSize = screenWidth >= 1440
        ? 72.sp
        : screenWidth >= 1024
            ? 64.sp
            : screenWidth >= 600
                ? 58.sp
                : 48.sp;

    final subtitleFontSize = screenWidth < 600 ? 20.sp : 18.sp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextReveal(
          maxHeight: 120.h,
          controller: controller,
          textRevealAnimation: textRevealAnimation,
          textOpacityAnimation: textOpacityAnimation,
          child: Text(
            'Trusted',
            style: TextStyle(
              fontFamily: 'RO',
              fontSize: headingFontSize,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ),
        TextReveal(
          maxHeight: 120.h,
          controller: controller,
          textRevealAnimation: textRevealAnimation,
          textOpacityAnimation: textOpacityAnimation,
          child: Text(
            'Preservation',
            style: TextStyle(
              fontFamily: 'RO',
              fontSize: headingFontSize,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 30.h),
        TextTransform(
          maxHeight: 100.h,
          controller: controller,
          textOpacityAnimation: textOpacityAnimation,
          child: Text(
            'Simplifying Numbers. Amplifying Growth.',
            style: TextStyle(
              fontFamily: 'RO',
              fontSize: subtitleFontSize,
              fontWeight: FontWeight.w300,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

class FirstPageImage extends StatefulWidget {
  const FirstPageImage({super.key});

  @override
  State<FirstPageImage> createState() => _FirstPageImageState();
}

class _FirstPageImageState extends State<FirstPageImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.2, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 400), () {
      if (_controller.isDismissed) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double height;
    final double scale = 1.5;

    if (screenWidth >= 1440) {
      height = 900.h;
    } else if (screenWidth >= 1024) {
      height = 850.h;
    } else if (screenWidth >= 600) {
      height = 700.h;
    } else {
      height = 500.h;
    }

    return SlideTransition(
      position: _slideAnimation,
      child: Transform.scale(
        scale: scale,
        child: Lottie.asset(
          'assets/images/Main Scene.json',
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
