import 'package:flutter/material.dart';

class SmartLearnAppDrawer extends StatelessWidget {
  const SmartLearnAppDrawer({super.key});

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

          // Lernaktivität
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Lernaktivität'),
            onTap: () {
              Navigator.pop(context); // Drawer schließen
              // danach navigieren
            },
          ),

          // Einstellungen
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Einstellungen'),
            onTap: () => Navigator.pop(context),
          ),

          // Hilfe & Feedback
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Hilfe & Feedback'),
            onTap: () => Navigator.pop(context),
          ),

          const Divider(),

          // Abmelden
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Abmelden'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
