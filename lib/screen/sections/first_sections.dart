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
  late AnimationController controller;
  late Animation<double> textRevealAnimation;
  late Animation<double> textOpacityAnimation;

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
    final bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

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
                _TextColumn(controller, textRevealAnimation, textOpacityAnimation),
                SizedBox(height: 30.h),
                SizedBox(height: 400.h, child: FirstPageImage()),
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 5,
                  child: _TextColumn(controller, textRevealAnimation, textOpacityAnimation),
                ),
                Expanded(flex: 7, child: FirstPageImage()),
              ],
            ),
    );
  }
}

class _TextColumn extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> textRevealAnimation;
  final Animation<double> textOpacityAnimation;

  const _TextColumn(this.controller, this.textRevealAnimation, this.textOpacityAnimation, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive font size for titles
    double headingFontSize;
    if (screenWidth >= 1440) {
      headingFontSize = 72.sp;
    } else if (screenWidth >= 1024) {
      headingFontSize = 64.sp;
    } else if (screenWidth >= 600) {
      headingFontSize = 58.sp;
    } else {
      headingFontSize = 48.sp; // Increased from 42.sp for better mobile readability
    }

    // Responsive font size for subtitle
    double subtitleFontSize = screenWidth < 600 ? 20.sp : 18.sp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextReveal(
          maxHeight: 120.h, // More breathing space
          controller: controller,
          textOpacityAnimation: textOpacityAnimation,
          textRevealAnimation: textRevealAnimation,
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
          textOpacityAnimation: textOpacityAnimation,
          textRevealAnimation: textRevealAnimation,
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
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.2, 0.0), // Right to left
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
    final bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    final screenWidth = MediaQuery.of(context).size.width;

double scale;
double height;

if (screenWidth >= 1440) {
  scale = 1.6;
  height = 900.h;
} else if (screenWidth >= 1024) {
  scale = 1.5;
  height = 850.h;
} else if (screenWidth >= 600) {
  scale = 1.5;
  height = 700.h;
} else {
  scale = 1.5;
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
