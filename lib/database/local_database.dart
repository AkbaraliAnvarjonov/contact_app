import 'package:contact_app/data/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static String tableName = "contact";
  static LocalDatabase getInstance = LocalDatabase._init();

  Database? _database;
  LocalDatabase._init();

  Future<Database> getDb() async {
    if (_database == null) {
      _database = await _initDB("contact.db");
      return _database!;
    }

    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, fileName);

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
        String textType = "TEXT";

        await db.execute('''
        CREATE TABLE $tableName (
            ${ContactFields.id} $idType,
            ${ContactFields.name} $textType,
            ${ContactFields.number} $textType,
            ${ContactFields.date} $textType
            )
            ''');
      },
    );
    return database;
  }

  static Future<ContactModel> insertContactDatabase(ContactModel contac) async {
    var database = await getInstance.getDb();
    int id = await database.insert(tableName, contac.toJson());
    return contac.copyWith(id: id);
  }

  static Future<List<ContactModel>> getList() async {
    var database = await getInstance.getDb();
    var listOfTodos = await database.query(tableName, columns: [
      ContactFields.id,
      ContactFields.name,
      ContactFields.number,
      ContactFields.date,
    ]);
    var list = listOfTodos.map((e) => ContactModel.fromJson(e)).toList();
    return list;
  }

  static Future<ContactModel> updateContactById(
      ContactModel updatedContact) async {
    var database = await getInstance.getDb();
    int id = await database.update(
      tableName,
      updatedContact.toJson(),
      where: 'id = ?',
      whereArgs: [updatedContact.id],
    );
    return updatedContact.copyWith(id: id);
  }

  static Future<int> deleteContactById(int id) async {
    var database = await getInstance.getDb();
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<ContactModel>> getContactByTitle(
      {String title = ''}) async {
    var database = await getInstance.getDb();

    if (title.isNotEmpty) {
      var listOfTodos = await database.query(
        tableName,
        where: 'title LIKE ?',
        whereArgs: ['%$title%'],
      );
      var list = listOfTodos.map((e) => ContactModel.fromJson(e)).toList();
      return list;
    } else {
      var listOfTodos = await database.query(tableName, columns: [
        ContactFields.id,
        ContactFields.name,
        ContactFields.name,
        ContactFields.date,
      ]);

      var list = listOfTodos.map((e) => ContactModel.fromJson(e)).toList();
      return list;
    }
  }

  // static Future<List<ContactModel>> getTodosIsCompleted(int isCompleted,
  //     {String title = ''}) async {
  //   var database = await getInstance.getDb();
  //   if (title.isNotEmpty) {
  //     var listOfTodos = await database.query(
  //       tableName,
  //       where: 'title LIKE ? AND ${C.isCompleted} = ?',
  //       whereArgs: ['%$title%', '$isCompleted'],
  //     );
  //     var list = listOfTodos.map((e) => TodoModel.fromJson(e)).toList();
  //     return list;
  //   } else {
  //     var listOfTodos = await database.query(tableName,
  //         columns: [
  //           TodoFields.id,
  //           TodoFields.title,
  //           TodoFields.description,
  //           TodoFields.date,
  //           TodoFields.priority,
  //           TodoFields.categoryId,
  //           TodoFields.isCompleted
  //         ],
  //         where: '${TodoFields.isCompleted} = ?',
  //         whereArgs: ['$isCompleted']);

  //     var list = listOfTodos.map((e) => TodoModel.fromJson(e)).toList();
  //     await Future.delayed(const Duration(seconds: 3));

  //     return list;
  //   }
  // }
}
