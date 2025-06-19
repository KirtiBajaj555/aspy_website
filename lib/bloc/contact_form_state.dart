part of 'contact_form_bloc.dart';

abstract class ContactFormState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactFormInitial extends ContactFormState {}

class ContactFormSubmitting extends ContactFormState {}

class ContactFormSuccess extends ContactFormState {}

class ContactFormFailure extends ContactFormState {
  final String error;
  ContactFormFailure({required this.error});

  @override
  List<Object> get props => [error];
}
