import 'package:contact_app/data/models/contact_model.dart';
import 'package:contact_app/database/local_database.dart';

class ContacstRepository {
  Future<List<ContactModel>> loadContacts() => LocalDatabase.getList();
  Future<int> deleteContact({required int id}) =>
      LocalDatabase.deleteContactById(id);
  Future updateContact({required ContactModel contactModel}) =>
      LocalDatabase.updateContactById(contactModel);

  Future<ContactModel> addContact(ContactModel contactModel) =>
      LocalDatabase.insertContactDatabase(contactModel);
}
