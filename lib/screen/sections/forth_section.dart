import '/bloc/screen_offset.dart';
import '/constant/color.dart';
import '/model/items.dart';
import '/screen/widget/item_card.dart';
import '/screen/widget/text_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForthSection extends StatefulWidget {
  const ForthSection({Key? key}) : super(key: key);

  @override
  State<ForthSection> createState() => _ForthSectionState();
}

class _ForthSectionState extends State<ForthSection>
    with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DisplayOffset, ScrollOffset>(
          buildWhen: (previous, current) {
            if ((current.scrollOffsetValue >= 1500 &&
                    current.scrollOffsetValue <= 2600) ||
                controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
              if (state.scrollOffsetValue > 2200.0) {
                controller.forward();
              } else {
                controller.reverse();
              }
            return Column(
              children: [
                TextReveal(
                  controller: controller,
                  maxHeight: 70.0,
                  child: const Text(
                    'OUR SERVICES',
                    style: TextStyle(
                      fontFamily: 'RO',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                
                Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 100,
                  runSpacing: 70,
                  children: items
                      .map(
                        (item) => ItemCard(
                          image: item.image,
                          title: item.title,
                          subtitle: item.subtitle,
                        ),
                      )
                      .toList(),
                )
              ],
            );
          },
        )
      ],
    );
  }
}
