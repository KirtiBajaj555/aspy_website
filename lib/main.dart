import '/bloc/screen_offset.dart';
import '/constant/color.dart';
import '/screen/whole_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASPY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Section keys
  final aboutKey = GlobalKey();
  final servicesKey = GlobalKey();
  final sectorsKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 420,
        backgroundColor: AppColors.secondaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            height: 200,
            child: Image.asset(
              'assets/images/ASPY.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => scrollToSection(aboutKey), // Home scrolls to About
            child: const Text(
              'Home',
              style: _navStyle,
            ),
          ),
          TextButton(
            onPressed: () => scrollToSection(aboutKey),
            child: const Text(
              'About',
              style: _navStyle,
            ),
          ),
          TextButton(
            onPressed: () => scrollToSection(servicesKey),
            child: const Text(
              'Services',
              style: _navStyle,
            ),
          ),
          TextButton(
            onPressed: () => scrollToSection(sectorsKey),
            child: const Text(
              'Sectors',
              style: _navStyle,
            ),
          ),
          TextButton(
            onPressed: () => scrollToSection(contactKey),
            child: const Text(
              'Contact Us',
              style: _navStyle,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.scaffoldColor,
      body: BlocProvider(
        create: (context) => DisplayOffset(ScrollOffset(scrollOffsetValue: 0)),
        child: WholeScreen(
          aboutKey: aboutKey,
          servicesKey: servicesKey,
          sectorsKey: sectorsKey,
          contactKey: contactKey,
        ),
      ),
    );
  }
}

const _navStyle = TextStyle(
  fontFamily: 'RO',
  fontSize: 14,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);
