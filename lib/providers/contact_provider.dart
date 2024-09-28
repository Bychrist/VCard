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
    // contactList.clear();
    contactList = await db.getAllContacts();
    notifyListeners();
    return contactList;
  }

  Future<List<ContactModel>> getAllFavoriteContacts() async {
    // contactList.clear();
    contactList = await db.getAllFavoriteContacts();
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

  Future<void> updateFavorite(ContactModel contactModel) async {
    final value = contactModel.favorite ? 0 : 1;
    await db.updateFavorite(contactModel.id, value);
    final index = contactList.indexOf(contactModel);
    contactList[index].favorite = !contactList[index].favorite;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getContactDetail(int id) async {
    return db.getContactDetails(id);
  }
}
