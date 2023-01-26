import 'package:contact_app/data/models/contact_model.dart';

abstract class GetContactsState {}

class InitialContactState extends GetContactsState {}

class LoadContactsInProgress extends GetContactsState {}

class LoadContactsInSuccess extends GetContactsState {
  LoadContactsInSuccess({required this.contacts});

  final List<ContactModel> contacts;
}
