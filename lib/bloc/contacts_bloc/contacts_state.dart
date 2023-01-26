import 'package:contact_app/data/models/contact_model.dart';
import 'package:equatable/equatable.dart';

class ContactsState extends Equatable {
  final ContactStatus status;
  final String statusText;
  final List<ContactModel> contacts;

  const ContactsState({
    required this.status,
    required this.statusText,
    required this.contacts,
  });

  ContactsState copyWith({
    ContactStatus? status,
    List<ContactModel>? contactModel,
    String? statusText,
  }) =>
      ContactsState(
        status: status ?? this.status,
        statusText: statusText ?? this.statusText,
        contacts: contactModel ?? this.contacts,
      );

  @override
  List<Object?> get props => [
        status,
        statusText,
        contacts,
      ];
}

enum ContactStatus {
  loading,
  pure,
  contactAdded,
  contactUptaded,
  contactDeleted,
}
