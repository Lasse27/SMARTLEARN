import 'package:flutter/material.dart';
import 'package:frontend/widgets/activity_streak_map.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Willkommen zurück!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('45 🔥', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 12),
        ActivityStreakMap(),
        SizedBox(height: 24),
        // SectionHeader(icon: Icons.history, title: 'Kürzlich bearbeitet'),
        // TaskTile(
        //   title: 'Zaunkosten',
        //   subtitle: 'Herr Bauer benötigt für seinen Garten ...',
        // ),
        // TaskTile(
        //   title: 'Eintritt für Museumsbesuch',
        //   subtitle: 'Frau Schilde geht mit ihren 24 Schülern ...',
        // ),
        // SizedBox(height: 16),
        // SectionHeader(icon: Icons.track_changes, title: 'Herausforderungen'),
        // TaskTile(
        //   title: 'Wöchentliche Herausforderung',
        //   subtitle: 'Traust du dich?',
        // ),
        // TaskTile(
        //   title: 'Tägliche Herausforderung',
        //   subtitle: 'Wachse über deine Grenzen hinaus!',
        // ),
      ],
    );
  }
}
