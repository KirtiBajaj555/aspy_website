import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../bloc/screen_offset.dart';
import '../constant/color.dart';
import 'whole_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final servicesKey = GlobalKey();
  final sectorsKey = GlobalKey();
  final contactKey = GlobalKey();

  final ScrollController scrollController = ScrollController();

  /// 🔑 Fixed navigation: always scrolls to the right section
  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration:
                        const BoxDecoration(color: AppColors.scaffoldColor),
                    child: Image.asset(
                      'assets/images/apple-touch-icon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  _DrawerNavItem(
                      label: 'Home', onTap: () => _handleDrawerNav(homeKey)),
                  _DrawerNavItem(
                      label: 'About', onTap: () => _handleDrawerNav(aboutKey)),
                  _DrawerNavItem(
                      label: 'Services',
                      onTap: () => _handleDrawerNav(servicesKey)),
                  _DrawerNavItem(
                      label: 'Sectors',
                      onTap: () => _handleDrawerNav(sectorsKey)),
                  _DrawerNavItem(
                      label: 'Contact Us',
                      onTap: () => _handleDrawerNav(contactKey)),
                ],
              ),
            )
          : null,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isMobile ? 60.h : 120.h),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: isMobile ? 60.h : 120.h,
          leadingWidth: isMobile ? 150.w : 250.w,
          leading: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Image.asset(
              'assets/images/apple-touch-icon.png',
              fit: BoxFit.contain,
              height: isMobile ? 50.h : 100.h,
              width: isMobile ? 100.w : 200.w,
            ),
          ),
          centerTitle: true,
          title: isMobile
              ? Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NavButton(
                        label: 'Home', onTap: () => scrollToSection(homeKey)),
                    _NavButton(
                        label: 'About', onTap: () => scrollToSection(aboutKey)),
                    _NavButton(
                        label: 'Services',
                        onTap: () => scrollToSection(servicesKey)),
                    _NavButton(
                        label: 'Sectors',
                        onTap: () => scrollToSection(sectorsKey)),
                    _NavButton(
                        label: 'Contact Us',
                        onTap: () => scrollToSection(contactKey)),
                  ],
                ),
        ),
      ),
      backgroundColor: AppColors.scaffoldColor,
      body: BlocProvider(
        create: (_) => DisplayOffset(ScrollOffset(scrollOffsetValue: 0)),
        child: WholeScreen(
          homeKey: homeKey,
          aboutKey: aboutKey,
          servicesKey: servicesKey,
          sectorsKey: sectorsKey,
          contactKey: contactKey,
          scrollController: scrollController,
        ),
      ),
    );
  }

  void _handleDrawerNav(GlobalKey key) {
    Navigator.of(context).pop(); // Close drawer
    scrollToSection(key);
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'RO',
            fontSize: 14.sp.clamp(12.sp, 18.sp),
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _DrawerNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _DrawerNavItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
