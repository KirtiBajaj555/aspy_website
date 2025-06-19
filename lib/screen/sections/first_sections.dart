import '/constant/color.dart';
import '/screen/widget/text_transform.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widget/text_reveal.dart';

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
  late Animation<double> descriptionAnimation;
  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1700,
      ),
      reverseDuration: const Duration(
        milliseconds: 375,
      ),
    );

    textRevealAnimation = Tween<double>(begin: 60.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.2, curve: Curves.easeOut)));

    textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.3, curve: Curves.easeOut)));
    Future.delayed(const Duration(milliseconds: 1000), () {
      controller.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      decoration: const BoxDecoration(color: AppColors.scaffoldColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 90, top: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextReveal(
                    maxHeight: 100,
                    controller: controller,
                    textOpacityAnimation: textOpacityAnimation,
                    textRevealAnimation: textRevealAnimation,
                    child: const Text(
                      'Trusted ',
                      style: TextStyle(
                          fontFamily: 'RO',
                          fontSize: 45,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  TextReveal(
                    maxHeight: 100,
                    controller: controller,
                    textOpacityAnimation: textOpacityAnimation,
                    textRevealAnimation: textRevealAnimation,
                    child: const Text(
                      'Preservation',
                      style: TextStyle(
                          fontFamily: 'RO',
                          fontSize: 45,
                          color: Color.fromARGB(255, 3, 3, 3),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextTransform(
                    maxHeight: 100,
                    controller: controller,
                    textOpacityAnimation: textOpacityAnimation,
                    //textRevealAnimation: textRevealAnimation,
                    child: const Text(
                      'Simplifying Numbers. Amplifying Growth..',
                      style: TextStyle(
                          fontFamily: 'RO',
                          fontSize: 13,
                          color: Color.fromARGB(255, 18, 18, 18),
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                 
                ],
              ),
            ),
          ),
          const Expanded(flex: 9, child: FirstPageImage())
        ],
      ),
    );
  }
}

class FirstPageImage extends StatefulWidget {
  const FirstPageImage({
    Key? key,
  }) : super(key: key);

  @override
  State<FirstPageImage> createState() => _FirstPageImageState();
}

class _FirstPageImageState extends State<FirstPageImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 775));

    _animation = Tween<double>(begin: 920.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    super.initState();
    Future.delayed(const Duration(milliseconds: 375), () {
      if (_controller.isDismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              height: 920.0,
              width: double.infinity,
              child: child,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _animation.value,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.scaffoldColor,
                      AppColors.secondaryColor,
                    ],
                    tileMode: TileMode.mirror,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: Transform.scale(
      scale: 0.8,
      child: Lottie.asset(
        'assets/images/Main Scene.json',
       fit: BoxFit.cover,
  ),
),

    );
  }
}
