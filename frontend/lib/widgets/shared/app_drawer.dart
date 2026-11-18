import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        primary: true,
        children: [
          // Kopfbereich
          UserAccountsDrawerHeader(
            accountName: const Text('Max Mustermann'),
            accountEmail: const Text('max@beispiel.de'),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person, size: 32),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),

          // Aufgabensammlung / Library
          ListTile(
            leading: const Icon(Icons.library_books_outlined),
            title: const Text('Aufgabensammlung'),
            onTap: () {
              Navigator.pop(context);
              context.push('/home/library');
            },
          ),

          // Lernaktivität
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Lernaktivität'),
            onTap: () {
              Navigator.pop(context);
              // später z. B. context.push('/activity');
            },
          ),

          // Einstellungen
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Einstellungen'),
            onTap: () {
              Navigator.pop(context);
              // später navigieren
            },
          ),

          // Hilfe & Feedback
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Hilfe & Feedback'),
            onTap: () {
              Navigator.pop(context);
              // später navigieren
            },
          ),

          const Divider(),

          // Abmelden
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Abmelden'),
            onTap: () {
              Navigator.pop(context);
              // später Abmeldung durchführen
            },
          ),
        ],
      ),
    );
  }
}
