import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'contact_form_event.dart';
part 'contact_form_state.dart';

class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  ContactFormBloc() : super(ContactFormInitial()) {
    on<SubmitContactForm>((event, emit) async {
      emit(ContactFormSubmitting());
      try {
        // Simulate Google Sheets/API submission
        await Future.delayed(const Duration(seconds: 2));
        emit(ContactFormSuccess());
      } catch (e) {
        emit(ContactFormFailure(error: e.toString()));
      }
    });
  }
}
