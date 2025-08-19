import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/contact_form_bloc.dart';
import '../../constant/color.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  void _showContactForm(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: BlocProvider(
            create: (_) => ContactFormBloc(),
            child: const _ContactFormPopup(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldColor,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _showContactForm(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            child: const Text(
              'Connect With Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          const _OfficeInfoDisplay(),
        ],
      ),
    );
  }
}

class _ContactFormPopup extends StatefulWidget {
  const _ContactFormPopup({Key? key}) : super(key: key);

  @override
  State<_ContactFormPopup> createState() => _ContactFormPopupState();
}

class _ContactFormPopupState extends State<_ContactFormPopup> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  final _countryCode = TextEditingController(text: '+91');
  final _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder<ContactFormBloc, ContactFormState>(
        builder: (context, state) {
          if (state is ContactFormSuccess) {
            return const Center(
              child: Text(
                'Sent Successfully!',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          }

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Connect With Us',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RO',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      labelText: 'Your Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value != null && value.contains('@')
                        ? null
                        : 'Please enter a valid email',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: TextFormField(
                          controller: _countryCode,
                          decoration: const InputDecoration(
                            labelText: 'Code',
                            hintText: '+91',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            } else if (!value.startsWith('+')) {
                              return 'Must start with +';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            hintText: '10-digit number',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your number';
                            } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              return 'Enter 10 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _message,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a message' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is ContactFormSubmitting
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<ContactFormBloc>().add(
                                    SubmitContactForm(
                                      name: _name.text,
                                      email: _email.text,
                                      countryCode: _countryCode.text,
                                      phone: _phone.text,
                                      message: _message.text,
                                    ),
                                  );

                              final response = await http.post(
                                Uri.parse(
                                  'https://script.google.com/macros/s/AKfycbyWJGnmn8L0L7FfWIkFGfwm14Laq1dUvKvvx4wwu_1wLugt3lWwJQRHN-lEGmoZI1cT6w/exec',
                                ),
                                headers: {
                                  'Content-Type':
                                      'application/x-www-form-urlencoded',
                                },
                                body: {
                                  'name': _name.text,
                                  'email': _email.text,
                                  'countryCode': _countryCode.text,
                                  'phone': _phone.text,
                                  'message': _message.text,
                                },
                              );

                              if (response.statusCode == 200) {
                                if (!mounted) return;
                                Navigator.of(context).pop(); // close popup
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Submitted Successfully')),
                                );
                                _formKey.currentState?.reset();
                                _name.clear();
                                _email.clear();
                                _phone.clear();
                                _countryCode.text = '+91';
                                _message.clear();
                              } else {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Submission Failed')),
                                );
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkColor,
                      foregroundColor: Colors.white,
                    ),
                    child: state is ContactFormSubmitting
                        ? const CircularProgressIndicator()
                        : const Text('Send'),
                  ),
                  if (state is ContactFormFailure)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        'Error: ${state.error}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OfficeInfoDisplay extends StatelessWidget {
  const _OfficeInfoDisplay();

  Widget _card(String title, String address, String phoneNumber, String email) {
    return Container(
      width: 420,
      height: 340, // taller to fit email
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.redAccent, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            address,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.phone, size: 18, color: Colors.green),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  phoneNumber,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.email, size: 18, color: Colors.blueAccent),
              const SizedBox(width: 6),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: email,
                    );
                    if (await canLaunchUrl(emailLaunchUri)) {
                      await launchUrl(emailLaunchUri);
                    }
                  },
                  child: Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        List<Widget> allCards = [
          _card(
            'Head Office – Thane - Mumbai, Maharashtra',
            'A 002 Ratneshwar Park,\nNear Gram Panchayat Office,\nThane Bhiwandi Road,\nThane - 421302,\nDist-Thane,Maharashtra',
            '+91 7499618705',
            'cayogita@aspyllp.com',
          ),
          _card(
            'Branch Office – Ichalkaranji, Maharashtra',
            '12/91, Shri Hari Kunj,\nPawar Mala,\nOpp Prakash Light House,\nIchalkaranji– 416115,\nDist-Kolhapur,Maharashtra',
            '+91 7738770841',
            'capawanmaloo@aspyllp.com',
          ),
          _card(
            'Branch Office – Sangli, Maharashtra',
            'Gala No. 1, Suman Plaza,\nOpp Bagal Heights,\nKanya Shala Road,\nSangli – 416310,\nDist-Kolhapur,Maharashtra',
            '+91 8007711117',
            'caanant@aspyllp.com',
          ),
          _card(
            'Branch Office – Hupari, Maharashtra',
            '1st Floor, Sapate Building,\nOpp. Laxmidevi Girls School,\nMain Road, Shivaji Nagar,\nHupari-416203, \nDist- Kolhapur,Maharashtra - 416203',
            '+91 9021275083, 0230-2959246',
            'cayogesh@aspyllp.com',
          ),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Our Offices',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            isMobile
                ? Column(
                    children: allCards
                        .map((card) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: card,
                            ))
                        .toList(),
                  )
                : Wrap(
                    spacing: 30,
                    runSpacing: 30,
                    alignment: WrapAlignment.center,
                    children: allCards,
                  ),
          ],
        );
      },
    );
  }
}
