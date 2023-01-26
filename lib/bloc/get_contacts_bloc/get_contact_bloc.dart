import 'package:contact_app/bloc/get_contacts_bloc/get_contact_event.dart';
import 'package:contact_app/bloc/get_contacts_bloc/get_contact_state.dart';
import 'package:contact_app/data/contacts_repository/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetContactsBloc extends Bloc<GetContactsEvent, GetContactsState> {
  GetContactsBloc({required this.contactRepository})
      : super(InitialContactState()) {
    on<FetchContactsInfo>(_fetchContactsList);
  }

  final ContacstRepository contactRepository;

  _fetchContactsList(FetchContactsInfo event, Emitter emit) async {
    emit(LoadContactsInProgress());
    var contacts = await contactRepository.loadContacts();
    emit(LoadContactsInSuccess(contacts: contacts));
  }
}
