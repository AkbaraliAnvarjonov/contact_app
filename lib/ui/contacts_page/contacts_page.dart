import 'package:contact_app/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:contact_app/bloc/contacts_bloc/contacts_event.dart';
import 'package:contact_app/bloc/get_contacts_bloc/get_contact_bloc.dart';
import 'package:contact_app/bloc/get_contacts_bloc/get_contact_event.dart';
import 'package:contact_app/bloc/get_contacts_bloc/get_contact_state.dart';
import 'package:contact_app/ui/add_contact_page/add_contacts_page.dart';
import 'package:contact_app/ui/update_contact_page.dart/update_contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: BlocConsumer<GetContactsBloc, GetContactsState>(
        builder: (context, state) {
          if (state is InitialContactState) {
            return const Text("Hali data yo'q");
          } else if (state is LoadContactsInProgress) {
            return const CircularProgressIndicator();
          } else if (state is LoadContactsInSuccess) {
            return ListView.builder(
              itemCount: state.contacts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateContactsPage(
                            contactModel: state.contacts[index],
                          ),
                        ));
                  },
                  title: Text(state.contacts[index].name),
                  subtitle: Text(state.contacts[index].number),
                  trailing: IconButton(
                      onPressed: () {
                        BlocProvider.of<ContactsBloc>(context).add(
                            DeleteContact(
                                contactId: state.contacts[index].id!));
                        BlocProvider.of<GetContactsBloc>(context)
                            .add(FetchContactsInfo());
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                );
              },
            );
          }
          return const SizedBox();
        },
        listener: (context, state) {},
      ),
      floatingActionButton: IconButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddContactsPage(),
              )),
          icon: const Icon(Icons.add)),
    );
  }
}
