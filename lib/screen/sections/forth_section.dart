import '/bloc/screen_offset.dart';
import '/model/items.dart';
import '/screen/widget/item_card.dart';
import '/screen/widget/text_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screen/widget/Services_item_card.dart';

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
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 375),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool _isVisible(BuildContext context, int scrollOffset) {
    // Get this widget’s position relative to the screen
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return false;

    final position = renderBox.localToGlobal(Offset.zero).dy;
    final screenHeight = MediaQuery.of(context).size.height;

    // Consider visible if top of widget enters screen area
    return position < screenHeight && position + renderBox.size.height > 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayOffset, ScrollOffset>(
      builder: (context, state) {
        final visible = _isVisible(context, state.scrollOffsetValue);

        if (visible) {
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
                  fontSize: 22,
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
                    (item) => FlipItemCard(
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
    );
  }
}
