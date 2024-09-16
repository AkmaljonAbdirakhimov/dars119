import 'package:dars119/features/contacts/controllers/contact_controller.dart';
import 'package:flutter/material.dart';

import 'package:dars119/features/contacts/models/contact.dart';
import 'package:provider/provider.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  const ContactItem({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.fullname),
      subtitle: Text(contact.phone),
      trailing: IconButton(
        onPressed: () {
          context.read<ContactController>().deleteContact(id: contact.id);
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
