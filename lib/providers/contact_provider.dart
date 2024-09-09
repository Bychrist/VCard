import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vcard_project/db/db_helper.dart';
import 'package:vcard_project/models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];
  final db = DbHelper();

  Future<int> insertContact(ContactModel contactModel) async {
    final rowId = await db.insert(contactModel);
    contactModel.id = rowId;
    contactList.add(contactModel);
    notifyListeners();
    return rowId;
  }

  Future<List<ContactModel>> getAllContacts() async {
    contactList = await db.getAllContacts();
    notifyListeners();
    return contactList;
  }

  Future<int> deleteContact(int id) async {
    final rowid = await db.deleteContact(id);
    if (rowid > 0) {
      contactList.removeWhere((contact) => contact.id == id);
      notifyListeners();
      return id;
    }
    return rowid;
  }
}
