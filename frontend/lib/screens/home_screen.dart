import 'package:material_ui/material_ui.dart';
import 'package:frontend/widgets/screens/homescreen/activity_streak_map.dart';
import 'package:frontend/widgets/shared/sections/section.dart';
import 'package:frontend/widgets/shared/sections/section_item.dart';

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
        SizedBox(height: 12),
        Section(
          title: "Kürzlich bearbeitet",
          iconData: Icons.history,
          items: [
            SectionItem(
              title: "Kürzlich Testitem 1",
              subtitle: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            SectionItem(
              title: "Kürzlich Testitem 2",
              subtitle: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            SectionItem(
              title: "Kürzlich Testitem 3",
              subtitle: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
          ],
        ),
        SizedBox(height: 12),
        Section(
          title: "Tägliche Herausforderungen",
          iconData: Icons.dangerous,
          items: [
            SectionItem(
              title: "Tägliche Testitem 1",
              subtitle: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            SectionItem(
              title: "Tägliche Testitem 2",
              subtitle: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            SectionItem(
              title: "Tägliche Testitem 3",
              subtitle: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
          ],
        ),
        SizedBox(height: 12),
        Section(
          title: "Wöchentliche Herausforderungen",
          iconData: Icons.warning,
          items: [
            SectionItem(
              title: "Wöchentliche Testitem 1",
              subtitle: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            SectionItem(
              title: "Wöchentliche Testitem 2",
              subtitle: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            SectionItem(
              title: "Wöchentliche Testitem 3",
              subtitle: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
          ],
        ),
      ],
    );
  }
}
