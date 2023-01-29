import 'package:contact_app/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:contact_app/bloc/contacts_bloc/contacts_event.dart';
import 'package:contact_app/bloc/contacts_bloc/contacts_state.dart';
import 'package:contact_app/bloc/get_contacts_bloc/get_contact_bloc.dart';
import 'package:contact_app/bloc/get_contacts_bloc/get_contact_event.dart';
import 'package:contact_app/data/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

TextEditingController nameController = TextEditingController();
TextEditingController numberController = TextEditingController();

class UpdateContactsPage extends StatelessWidget {
  ContactModel contactModel;
  UpdateContactsPage({
    super.key,
    required this.contactModel,
  });

  @override
  Widget build(BuildContext context) {
    nameController.text = contactModel.name;
    numberController.text = contactModel.number;
    return Scaffold(
      appBar: AppBar(title: const Text("Update Contact")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.name,
              controller: nameController,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              controller: numberController,
            ),
            const SizedBox(height: 12),
            BlocConsumer<ContactsBloc, ContactsState>(
                builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        numberController.text.isNotEmpty) {
                      BlocProvider.of<ContactsBloc>(context).add(
                        UpdateContact(
                            contactModel: ContactModel(
                          date: DateTime.now().toString(),
                          name: nameController.text,
                          number: numberController.text,
                          id: contactModel.id,
                        )),
                      );
                    }
                  },
                  child: const Text("Add"));
            }, listener: (context, state) {
              if (state.status == ContactStatus.contactUptaded) {
                BlocProvider.of<GetContactsBloc>(context)
                    .add(FetchContactsInfo());
                Navigator.pop(context);
              }
            })
          ],
        ),
      ),
    );
  }
}
