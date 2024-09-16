import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:vcard_project/models/contact_model.dart';

class DbHelper {
  Future<Database> _Open() async {
    final String _createTableContact = '''create table $tableContact(
    $tblContactColId integer primary key autoincrement,
    $tblContactColName text,
    $tblContactColMobile text,
    $tblContactColEmail text,
    $tblContactColDesignation text,
    $tblContactColAddress text,
    $tblContactColCompany text,
    $tblContactColImage text,
    $tblContactColWebsite text,
    $tblContactColFavorite integer)''';

    final String _dropTableContact = 'DROP TABLE IF EXISTS $tableContact';

    final root = await getDatabasesPath();
    final dbPath = p.join(root, 'contact.db');

    return openDatabase(dbPath, version: 2, // Increment the version number
        onCreate: (db, version) {
      db.execute(_createTableContact);
    }, onUpgrade: (db, oldVersion, newVersion) {
      if (oldVersion < newVersion) {
        db.execute(_dropTableContact); // Drop the table if upgrading
        db.execute(_createTableContact); // Recreate the table
      }
    });
  } //_open method

  //insert method
  Future<int> insert(ContactModel contactModel) async {
    final db = await _Open();
    return await db.insert(tableContact, contactModel.toMap());
  }
  //close insert method

  //get all rows from the contact table
  Future<List<ContactModel>> getAllContacts() async {
    final db = await _Open();
    final mapList = await db.query(tableContact);
    return List.generate(
        mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }
  // close get all rowss from the contact table

  //delete a contact
  Future<int> deleteContact(int id) async {
    final db = await _Open();
    final dbId = await db
        .delete(tableContact, where: '$tblContactColId = ?', whereArgs: [id]);

    return dbId;
  }

  Future<int> updateContactField(int id, Map<String, dynamic> map) async {
    final db = await _Open();
    return db.update(tableContact, map,
        where: '$tblContactColId = ?', whereArgs: [id]);
  }

  Future<int> updateFavorite(int id, int value) async {
    final db = await _Open();
    return db.update(tableContact, {tblContactColFavorite: value},
        where: '$tblContactColId = ?', whereArgs: [id]);
  }
}
