import 'package:flutter/material.dart';
import 'package:vcard_project/db/db_helper.dart';
import 'package:vcard_project/models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];
  final db = DbHelper();

  Future<int> insertContact(ContactModel contactModel) async {
    return db.insert(contactModel);
  }

  Future<List<ContactModel>> getAllContacts() async {
    contactList = await db.getAllContacts();
    notifyListeners();
    return contactList;
  }
}
