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
  @override
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
      reverseDuration: const Duration(
        milliseconds: 375,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DisplayOffset, ScrollOffset>(
          buildWhen: (previous, current) {
            if ((current.scrollOffsetValue >= 2800 &&
                    current.scrollOffsetValue <= 4500) ||
                controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state.scrollOffsetValue > 4200.0) {
              //print(state.scrollOffsetValue);
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
                    'NEWS',
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
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 400,
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: news
                          .map((news) => NewsCard(
                                news,
                              ))
                          .toList()),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
