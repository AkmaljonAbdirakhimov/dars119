import 'package:dars119/features/contacts/controllers/contact_controller.dart';
import 'package:dars119/features/contacts/services/contact_local_service.dart';
import 'package:dars119/features/contacts/views/contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final contactService = ContactLocalService();
  await contactService.init();

  runApp(MainApp(contactService: contactService));
}

class MainApp extends StatelessWidget {
  final ContactLocalService contactService;
  const MainApp({super.key, required this.contactService});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactController(
        contactLocalService: contactService,
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ContactsScreen(),
      ),
    );
  }
}
