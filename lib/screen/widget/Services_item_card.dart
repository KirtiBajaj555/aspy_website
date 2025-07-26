import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class FlipItemCard extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle; // subtitle as single string with newlines

  const FlipItemCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<FlipItemCard> createState() => _FlipItemCardState();
}

class _FlipItemCardState extends State<FlipItemCard> {
  final FlipCardController _controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 400,
      child: GestureDetector(
        onTap: () {
          _controller.flipcard(); // Manual flip on tap
        },
        child: FlipCard(
          rotateSide: RotateSide.bottom,
          axis: FlipAxis.horizontal,
          onTapFlipping: false, // Disable auto flip on touch
          controller: _controller,
          frontWidget: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(widget.image, height: 80),
                  const SizedBox(height: 20),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          backWidget: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.blueGrey[50],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.5, // Line spacing
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
