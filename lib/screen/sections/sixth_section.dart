import '/bloc/screen_offset.dart';
import '/model/news.dart';
import '/screen/widget/news_card.dart';
import '/screen/widget/text_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/color.dart';

class SixthSection extends StatefulWidget {
  const SixthSection({Key? key}) : super(key: key);

  @override
  State<SixthSection> createState() => _SixthSectionState();
}

class _SixthSectionState extends State<SixthSection>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 375),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool _isVisible(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return false;

    final position = renderBox.localToGlobal(Offset.zero).dy;
    final screenHeight = MediaQuery.of(context).size.height;

    // ✅ Section is visible if it intersects with the screen
    return position < screenHeight && position + renderBox.size.height > 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayOffset, ScrollOffset>(
      builder: (context, state) {
        final visible = _isVisible(context);

        if (visible) {
          controller.forward();
        } else {
          controller.reverse();
        }

        return Column(
          children: [
            TextReveal(
              maxHeight: 70,
              controller: controller,
              child: const Text(
                'Sectors',
                style: TextStyle(
                  fontFamily: 'RO',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: AppColors.darkColor,
                ),
              ),
            ),
            TextReveal(
              maxHeight: 70,
              controller: controller,
              child: const Text(
                'Dive into Our Dynamics Feed',
                style: TextStyle(
                  fontFamily: 'RO',
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkColor,
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 400,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: news.map((n) => NewsCard(n)).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
