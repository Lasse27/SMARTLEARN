import 'package:material_ui/material_ui.dart';

import '../../components/cards/exercise_list_tile.dart';
import '../../components/navigation/app_header.dart';

class PracticeExercisesScreen extends StatelessWidget {
  const PracticeExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Generierte Aufgaben',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Kurz üben',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text('Wähle eine Aufgabe aus und starte direkt mit dem Üben.'),
          const SizedBox(height: 16),

          _section('Addition & Subtraktion', [
            'Aufgabe 1',
            'Aufgabe 2',
            'Aufgabe 3',
            'Aufgabe 4',
          ]),

          const SizedBox(height: 12),

          _section('Potenzen / Wurzeln', [
            'Aufgabe 5',
            'Aufgabe 6',
            'Aufgabe 7',
          ]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _section(String title, List<String> exercises) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        ...exercises.map(
          (exercise) => ExerciseListTile(
            title: exercise,
            status: ExerciseStatus.open,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
