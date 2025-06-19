part of 'contact_form_bloc.dart';

abstract class ContactFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitContactForm extends ContactFormEvent {
  final String name;
  final String email;
  final String countryCode;
  final String phone;
  final String message;

  SubmitContactForm({
    required this.name,
    required this.email,
    required this.countryCode,
    required this.phone,
    required this.message,
  });

  @override
  List<Object> get props => [name, email, countryCode, phone, message];
}
