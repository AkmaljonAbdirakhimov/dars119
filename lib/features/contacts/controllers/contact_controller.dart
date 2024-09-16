import 'package:dars119/features/contacts/services/contact_local_service.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class ContactController with ChangeNotifier {
  final ContactLocalService contactLocalService;

  ContactController({required this.contactLocalService});

  List<Contact> _contacts = [];

  Future<List<Contact>> get contacts async {
    // get contact
    _contacts = await contactLocalService.get();
    return [..._contacts];
  }

  Future<void> addContact({
    required String fullname,
    required String phone,
  }) async {
    // add contact
    await contactLocalService.insert(fullname: fullname, phone: phone);
    notifyListeners();
  }

  Future<void> deleteContact({
    required int id,
  }) async {
    // add contact
    await contactLocalService.delete(id);
    notifyListeners();
  }
}
