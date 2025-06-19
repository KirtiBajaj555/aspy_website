import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/screen_offset.dart';
import 'sections/first_sections.dart';
import 'sections/second_section.dart';
import 'sections/third_section.dart';
import 'sections/forth_section.dart';
import 'sections/sixth_section.dart';
import 'sections/eighth_section.dart';
import 'sections/ninth_section.dart';
import 'sections/contact_section.dart';

class WholeScreen extends StatefulWidget {
  final GlobalKey aboutKey;
  final GlobalKey servicesKey;
  final GlobalKey sectorsKey;
  final GlobalKey contactKey;

  const WholeScreen({
    super.key,
    required this.aboutKey,
    required this.servicesKey,
    required this.sectorsKey,
    required this.contactKey,
  });

  @override
  State<WholeScreen> createState() => _WholeScreenState();
}

class _WholeScreenState extends State<WholeScreen> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();

    controller.addListener(() {
      context.read<DisplayOffset>().changeDisplayOffset(
            (MediaQuery.of(context).size.height + controller.position.pixels)
                .toInt(),
          );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      children: [
        const FirstSection(),
        ThirdSection(key: widget.aboutKey), // ✅ About Section
        const SizedBox(height: 100.0),
        ForthSection(key: widget.servicesKey), // ✅ Services Section
        const SizedBox(height: 50.0),
        const EighthSection(),
        const SizedBox(height: 100.0),
        SixthSection(key: widget.sectorsKey), // ✅ Sectors Section
        const SizedBox(height: 100.0),
        ContactSection(key: widget.contactKey), // ✅ Contact Us Section
        const SizedBox(height: 80),
        const NinthSection(),
        const SizedBox(height: 100.0),
      ],
    );
  }
}
