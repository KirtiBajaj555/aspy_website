import '/bloc/screen_offset.dart';
import '/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      imagePath: 'assets/images/businessman-shows-his-finger-up.jpg',
      name: 'CA Pawan Maloo',
      role: 'Chartered Accountant',
      description: 'Expert in taxation and audit, with 10+ years of experience.',
    ),
    TeamMember(
      imagePath: 'assets/images/businessman-shows-his-finger-up.jpg',
      name: 'Riya Sharma',
      role: 'Flutter Developer',
      description: 'Passionate about mobile UI/UX and smooth app experiences.',
    ),
    TeamMember(
      imagePath: 'assets/images/businessman-shows-his-finger-up.jpg',
      name: 'Rahul Verma',
      role: 'Backend Engineer',
      description: 'Specializes in Node.js, Firebase, and API integrations.',
    ),
    TeamMember(
      imagePath: 'assets/images/businessman-shows-his-finger-up.jpg',
      name: 'Sneha Kapoor',
      role: 'UI Designer',
      description: 'Designs elegant interfaces for both web and mobile apps.',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Our Team',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RO',
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 30,
                runSpacing: 30,
                children: team.map((member) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
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
                            height: 220,
                            width: 220,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        member.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RO',
                        ),
                      ),
                      Text(
                        member.role,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'RO',
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 240, // or even MediaQuery.of(context).size.width * 0.4
                        child: Text(
                          member.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'RO',
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
