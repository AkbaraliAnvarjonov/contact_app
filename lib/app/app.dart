import 'package:contact_app/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:contact_app/bloc/get_contacts_bloc/get_contact_bloc.dart';
import 'package:contact_app/bloc/get_contacts_bloc/get_contact_event.dart';
import 'package:contact_app/data/contacts_repository/contacts_repository.dart';
import 'package:contact_app/ui/contacts_page/contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => ContacstRepository(),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => GetContactsBloc(
                      contactRepository: context.read<ContacstRepository>(),
                    )..add(FetchContactsInfo())),
            BlocProvider(
                create: (context) => ContactsBloc(
                      context.read<ContacstRepository>(),
                    ))
          ],
          child: const MyApp(),
        ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ContactsPage(),
    );
  }
}
