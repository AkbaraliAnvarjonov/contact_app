import 'package:contact_app/data/models/contact_model.dart';

abstract class ContactsEvent {}

class UpdateContact extends ContactsEvent {
   final ContactModel contactModel;
  UpdateContact({required this.contactModel});
}

class AddContact extends ContactsEvent {
  final ContactModel contactModel;
  AddContact({required this.contactModel});
}

class DeleteContact extends ContactsEvent {
  final int contactId;
  DeleteContact({required this.contactId});
}
