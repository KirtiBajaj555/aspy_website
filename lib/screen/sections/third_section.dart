import '/bloc/screen_offset.dart';
import '/constant/color.dart';
import '/screen/widget/text_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdSection extends StatefulWidget {
 const ThirdSection({Key? key}) : super(key: key);
 
  @override
  State<ThirdSection> createState() => _ThirdSectionState();
}

class _ThirdSectionState extends State<ThirdSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> imageRevealAnimation;
  late Animation<double> textRevealAnimation;
  late Animation<double> subTextOpacityAnimation;
  late Animation<double> subImageRevealAnimation;
  late Animation<Offset> offsetImage;
  late Animation<Offset> transform;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1700,
      ),
      reverseDuration: const Duration(
        milliseconds: 375,
      ),
    );

    imageRevealAnimation = Tween<double>(begin: 500.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.40, curve: Curves.easeOut)));

    textRevealAnimation = Tween<double>(begin: 70.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.30, 0.60, curve: Curves.easeOut)));

    subTextOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.50, 0.80, curve: Curves.easeOut)));
    offsetImage =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    transform =
        Tween<Offset>(begin: const Offset(10, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    subImageRevealAnimation = Tween<double>(begin: 0.0, end: 90.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.70, 1.0, curve: Curves.easeOut)));

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
    return BlocBuilder<DisplayOffset, ScrollOffset>(
      buildWhen: (previous, current) {
        if (current.scrollOffsetValue > 1200 || controller.isAnimating) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state.scrollOffsetValue > 1200) {
          controller.forward();
        } else {
          controller.reverse();
        }
        return Row(
          children: [
            Flexible(
              flex: 1,
              child: SlideTransition(
            position: offsetImage,
            child: SizedBox(
              width: 650, // adjust this value
              child: Image.asset(
                'assets/images/StockCake-Investigating Currency Details_1749042756.jpg',
                fit: BoxFit.contain,
              ),
            ),

              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextReveal(
                        maxHeight: 50,
                        controller: controller,
                        child: const Text(
                          'About us',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'RO',
                            fontWeight: FontWeight.normal,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    
                      SlideTransition(
                        position: transform,
                        // opacity: subTextOpacityAnimation,
                        child: const Text(
                          'A S P Y & CO LLP (ASPY) is a Chartered Accountants firm providing Assurance, Taxation and Advisory services. Revered for our professional ethos and technical expertise, drawn on perspicacity of over two decades of experience of the partners in their professional endeavours and a team of highly competent professionals, we provide efficacious solutions to our client’s needs, running into deep engagements.\n\n'
                          'Our philosophy is of partnering with our clients and not being a distant service provider. Since businesses are inherently different, we tailor our services to meet client’s specific needs and banish the ‘one-size-fits-all’ standardisation.\n\n'
                          'We recruit, train, motivate and retain highly capable and sharpest talent, who bring quality in their work and deliver the best solutions.\n\n'
                          'Head office in Ichalkaranji (Dist- Kolhapur, Maharashtra) with associates at Mumbai, Navi Mumbai, Thane and Pune locations and leverage our state-of-art infrastructure, wide network, best practices and people development programs. Under the able direction of partners and associates, ASPY’s team strength of over 30 people is uniquely positioned to provide you quality opinions and services. Our Inter-disciplinary approach renders to give you seamless value.\n\n'
                          'Serving to the wider business community, we enjoy unparalleled reputation and respect of our clients, who trust and rely on us for our expertise and professionalism.',
                             style: TextStyle(
                            fontFamily: 'RO',
                            fontSize: 18,
                            color: Colors.black,
                          
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
