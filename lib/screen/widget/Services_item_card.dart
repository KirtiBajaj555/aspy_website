import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class FlipItemCard extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;

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
  bool _isDesktop = false;
  bool _isFlipped = false; // track flip state

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.of(context).size.width;
    _isDesktop = width >= 1024; // breakpoint

    if (!_isDesktop) {
      // Small screen → auto flip then back
      Future.delayed(const Duration(seconds: 1), () {
        _flipToBack();
        Future.delayed(const Duration(seconds: 2), () {
          _flipToFront();
        });
      });
    }
  }

  void _flipToBack() {
    if (!_isFlipped) {
      _controller.flipcard();
      _isFlipped = true;
    }
  }

  void _flipToFront() {
    if (_isFlipped) {
      _controller.flipcard();
      _isFlipped = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget flipCardWidget = FlipCard(
      rotateSide: RotateSide.bottom,
      axis: FlipAxis.horizontal,
      onTapFlipping: !_isDesktop,
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
              children: [
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Desktop → flip on hover
    if (_isDesktop) {
      flipCardWidget = MouseRegion(
        onEnter: (_) {
          Future.delayed(const Duration(milliseconds: 150), () {
            _flipToBack();
          });
        },
        onExit: (_) {
          Future.delayed(const Duration(milliseconds: 150), () {
            _flipToFront();
          });
        },
        child: flipCardWidget,
      );
    }

    return SizedBox(
      width: 350,
      height: 400,
      child: flipCardWidget,
    );
  }
}
