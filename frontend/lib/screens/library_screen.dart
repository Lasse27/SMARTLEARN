import 'package:material_ui/material_ui.dart';

import '../../components/cards/category_card.dart';
import '../../components/navigation/app_header.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Aufgabensammlung',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Aufgabensammlung',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12),
          CategoryCard(
            title: 'Addition / Subtraktion',
            icon: Icons.calculate_outlined,
          ),
          CategoryCard(title: 'Multiplikation / Division', icon: Icons.close),
          CategoryCard(title: 'Potenzen / Wurzeln', icon: Icons.functions),
          CategoryCard(title: 'Dreisatz', icon: Icons.percent),
          CategoryCard(title: 'Geometrie', icon: Icons.category_outlined),
        ],
      ),
    );
  }
}
