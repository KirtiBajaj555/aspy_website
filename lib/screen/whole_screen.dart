import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/screen_offset.dart';
import 'sections/first_sections.dart';
import 'sections/third_section.dart';
import 'sections/forth_section.dart';
import 'sections/sixth_section.dart';
import 'sections/eighth_section.dart';
import 'sections/ninth_section.dart';
import 'sections/contact_section.dart';

class WholeScreen extends StatefulWidget {
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey servicesKey;
  final GlobalKey sectorsKey;
  final GlobalKey contactKey;
  final ScrollController scrollController;

  const WholeScreen({
    super.key,
    required this.homeKey,
    required this.aboutKey,
    required this.servicesKey,
    required this.sectorsKey,
    required this.contactKey,
    required this.scrollController,
  });

  @override
  State<WholeScreen> createState() => _WholeScreenState();
}

class _WholeScreenState extends State<WholeScreen> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      final offset = widget.scrollController.position.pixels;
      final screenHeight = MediaQuery.of(context).size.height;
      context.read<DisplayOffset>().changeDisplayOffset(
            (screenHeight + offset).toInt(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      children: [
        Container(key: widget.homeKey, child: const FirstSection()),
        Container(key: widget.aboutKey, child: const ThirdSection()),
        const SizedBox(height: 100),
        Container(key: widget.servicesKey, child: const ForthSection()),
        const SizedBox(height: 50),
        const EighthSection(),
        const SizedBox(height: 100),
        Container(key: widget.sectorsKey, child: const SixthSection()),
        const SizedBox(height: 100),
        Container(key: widget.contactKey, child: const ContactSection()),
        const SizedBox(height: 80),
        const NinthSection(),
        const SizedBox(height: 100),
      ],
    );
  }
}
