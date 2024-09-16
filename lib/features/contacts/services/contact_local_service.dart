import 'package:dars119/features/contacts/models/contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ContactLocalService {
  late final Database _database;
  final String _dbName = "contacts.db";
  final String _table = "contacts";
  final String _idColumn = "id";
  final String _fullnameColumn = "fullname";
  final String _phoneColumn = "phone";

  Future<void> init() async {
    final folder = await getApplicationDocumentsDirectory();
    final path = "${folder.path}/$_dbName";
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    final String query = """
      CREATE TABLE $_table 
      (
        $_idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
        $_fullnameColumn TEXT NOT NULL,
        $_phoneColumn TEXT NOT NULL
      )
""";

    await db.execute(query);
  }

  Future<List<Contact>> get() async {
    final List<Contact> contacts = [];
    final data = await _database.query(_table);

    for (var item in data) {
      final contact = Contact(
        id: item[_idColumn] as int,
        fullname: item[_fullnameColumn] as String,
        phone: item[_phoneColumn] as String,
      );

      contacts.add(contact);
    }

    return contacts;
  }

  Future<void> insert({
    required String fullname,
    required String phone,
  }) async {
    await _database.insert(_table, {
      _fullnameColumn: fullname,
      _phoneColumn: phone,
    });
  }

  Future<void> delete(int contactId) async {
    await _database.delete(_table, where: "id=$contactId");
  }
}
