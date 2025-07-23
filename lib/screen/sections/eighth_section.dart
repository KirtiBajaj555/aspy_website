import '/bloc/screen_offset.dart';
import '/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TeamMember {
  final String imagePath;
  final String name;
  final String role;
  final String description;

  const TeamMember({
    required this.imagePath,
    required this.name,
    required this.role,
    required this.description,
  });
}

class EighthSection extends StatefulWidget {
  const EighthSection({super.key});

  @override
  State<EighthSection> createState() => _EighthSectionState();
}

class _EighthSectionState extends State<EighthSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final List<TeamMember> team = const [
    TeamMember(
      imagePath: 'assets/images/Pawan_Photo.jpg',
      name: 'CA Pawan Maloo',
      role: 'Chartered Accountant',
      description:
          'FCA with over 25 years of experience in accounting, taxation, and corporate advisory. Holds a PG Diploma in International Finance and a B.Com (Hons.). Specializes in audits, GST, NRI taxation, forensic audits, and MSME/startup financing. '
          'ICAI-nominated faculty for GST, Excel, GMCS, and Orientation. Certified in forensic accounting, public finance, and concurrent bank audits. '
          'Led GST audits for listed infrastructure firms (₹3000+ Cr turnover) and brings 15+ years of corporate job experience.',
    ),
    TeamMember(
      imagePath: 'assets/images/businessman-shows-his-finger-up.jpg',
      name: 'CA Yogita Shinde',
      role: 'Chartered Accountant',
      description:
          'A Chartered Accountant (first attempt) with M.Com and B.Com degrees from Mumbai University. Brings over 16 years of experience in Indian and US accounting, taxation, financial reporting (including consolidated financials), and GST. '
          'Holds AICA Level-1 certification from ICAI, along with advanced diplomas in Software Engineering and Information Systems. '
          'Awarded “Women Entrepreneur of the Year” at the International Brilliance Awards 2024 and featured on The Pink Flower YouTube channel. '
          'Led major audits including Federal Bank (Statutory, FY 2022–23), IDBI Bank (Concurrent, FY 2023–24), Dena Bank (Revenue Audit), and Saraswat Bank (Internal Audit for 3 years). '
          'Also contributed as Finance Expert in SIL University’s AARAMBH Budgeting Event for two consecutive years.',
    ),
    TeamMember(
      imagePath: 'assets/images/CA_Yogesh_Neje.png',
      name: 'CA Yogesh Neje',
      role: 'Chartered Accountant',
      description:
          'FCA with over 10 years of experience in accounting, taxation, GST, and direct tax. Holds B.Com and M.Com degrees from Shivaji University, Kolhapur. Specializes in GST and income tax consultations, audits, return filings, appeals, and loan/project appraisals. '
          'Certified by ICAI in Concurrent Audit of Banks and in Public Finance & Government Accounting. '
          'Serves as Expert Director at Abasaheb Patil Rendal Sahkari Bank Ltd. for over 4 years and led its Concurrent Audit in FY 2021–22. '
          'Completed the Leadership Development Programme for Directors of Urban Co-operative Banks conducted by NCCE & MRSS, Pune.',
    ),
    TeamMember(
      imagePath: 'assets/images/Anant_Dhupad_Final.jpg',
      name: 'CA Anant Dhupad',
      role: 'Chartered Accountant',
      description:
          'FCA with over 10 years of experience in accounting, taxation, and auditing across various sectors. Holds a B.Com from Shivaji University, Kolhapur. Specializes in statutory and concurrent bank audits, internal audits, GST and direct tax consultations, real estate accounting, RERA compliance, project reports, loan appraisals, and subsidy applications under PSI schemes. '
          'Certified by ICAI in Concurrent Audit of Banks and holds a DISA (Information Systems Audit) qualification. '
          'Led audits for major banks including Bank of India (2019–2023), Bank of Maharashtra, Canara Bank, SBI, Tamilnad Mercantile Bank, Union Bank, and Mahalaxmi Co-op Bank.',
    ),
  ];

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayOffset, ScrollOffset>(
      buildWhen: (previous, current) {
        final shouldRebuild = current.scrollOffsetValue > 3500 &&
            current.scrollOffsetValue < 4600;
        return shouldRebuild || controller.isAnimating;
      },
      builder: (context, state) {
        if (state.scrollOffsetValue >= 3750 &&
            state.scrollOffsetValue <= 4400) {
          if (!controller.isAnimating &&
              controller.status != AnimationStatus.forward) {
            controller.forward();
          }
        } else {
          if (!controller.isAnimating &&
              controller.status != AnimationStatus.reverse) {
            controller.reverse();
          }
        }

        return Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 60.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Our Team',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RO',
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: team.map((member) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: ResponsiveRowColumn(
                          layout:ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                              ? ResponsiveRowColumnType.COLUMN
                              : ResponsiveRowColumnType.ROW,
                          rowMainAxisAlignment: MainAxisAlignment.start,
                          rowCrossAxisAlignment: CrossAxisAlignment.start,
                          columnMainAxisAlignment: MainAxisAlignment.center,
                          columnCrossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ResponsiveRowColumnItem(
                              rowFlex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.secondaryColor,
                                      blurRadius: 30,
                                      blurStyle: BlurStyle.outer,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    member.imagePath,
                                    height: 250,
                                    width: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const ResponsiveRowColumnItem(
                              child: SizedBox(width: 50, height: 30),
                            ),
                            ResponsiveRowColumnItem(
                              rowFlex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(24.0),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.secondaryColor.withOpacity(0.1),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      member.name,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'RO',
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      member.role,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'RO',
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      member.description,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'RO',
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
