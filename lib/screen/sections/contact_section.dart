import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/contact_form_bloc.dart';
import '../../constant/color.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  final _countryCode = TextEditingController(text: '+91');
  final _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactFormBloc(),
      child: Container(
        color: AppColors.secondaryColor,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 800;

            return SingleChildScrollView(
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFormSection(),
                        const SizedBox(height: 40),
                        const _OfficeInfoDisplay(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 35, child: _buildFormSection()),
                        const SizedBox(width: 40),
                        const Expanded(flex: 65, child: _OfficeInfoDisplay()),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
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
            child: Column(
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
                      : () {
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
          );
        },
      ),
    );
  }
}

class _OfficeInfoDisplay extends StatelessWidget {
  const _OfficeInfoDisplay();

  Widget _card(String title, String address) {
    return Container(
      width: 280,
      height: 220,
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
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            address,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headOfficeCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(30),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.redAccent, size: 24),
              SizedBox(width: 8),
              Text(
                'Head Office – Thane - Mumbai, Maharashtra',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'A 002 Ratneshwar Park,\nNear Gram Panchayat Office,\nThane Bhiwandi Road,\nThane - 421302',
            style: TextStyle(fontSize: 15, height: 1.5),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Offices',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 30),
        _headOfficeCard(),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _card(
              'Palus – Maharashtra',
              'Gala No. 1, Suman Plaza,\nOpp Bagal Heights,\nSangli – 416310',
            ),
            _card(
              'Ichalkaranji – Maharashtra',
              '12/91, Shri Hari Kunj,\nOpp Prakash Light House,\nKolhapur – 416115',
            ),
            _card(
              'Hupari – Maharashtra',
              'Sapate Building,\nOpp. Laxmidevi School,\nHupari – 416203',
            ),
          ],
        ),
      ],
    );
  }
}
