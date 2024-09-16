import 'package:dars119/features/contacts/controllers/contact_controller.dart';
import 'package:dars119/features/contacts/views/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(
            onPressed: () {
              const String fullname = "Alijon 3";
              const String phone = "+998 90 00 000 00 03";

              context
                  .read<ContactController>()
                  .addContact(fullname: fullname, phone: phone);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<ContactController>(
        builder: (context, contactController, child) {
          return FutureBuilder(
              future: contactController.contacts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                }

                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("NO DATA"),
                  );
                }

                final contacts = snapshot.data!;

                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return ContactItem(
                      contact: contacts[index],
                    );
                  },
                );
              });
        },
      ),
    );
  }
}
