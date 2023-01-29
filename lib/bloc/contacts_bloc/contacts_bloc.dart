import 'package:contact_app/bloc/contacts_bloc/contacts_event.dart';
import 'package:contact_app/bloc/contacts_bloc/contacts_state.dart';
import 'package:contact_app/data/contacts_repository/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContacstRepository contacstRepository;

  ContactsBloc(this.contacstRepository)
      : super(
          const ContactsState(
              contacts: [], statusText: "", status: ContactStatus.pure),
        ) {
    on<AddContact>(addContact);
    on<UpdateContact>(updateContact);
    on<DeleteContact>(deleteContact);
  }

  addContact(AddContact event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    var newContact = await contacstRepository.addContact(event.contactModel);
    if (newContact.id != null) {
      emit(state.copyWith(status: ContactStatus.contactAdded));
    }
  }

  updateContact(UpdateContact event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    var updatedId = await contacstRepository.updateContact(
        contactModel: event.contactModel);
    if (updatedId != -1) {
      emit(state.copyWith(status: ContactStatus.contactUptaded));
    }
  }

  deleteContact(DeleteContact event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    var deleteId = await contacstRepository.deleteContact(id: event.contactId);
    if (deleteId != -1) {
      emit(state.copyWith(status: ContactStatus.contactDeleted));
    }
  }
}
