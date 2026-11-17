import 'package:material_ui/material_ui.dart';

enum ExerciseStatus { open, correct, incorrect }

class ExerciseListTile extends StatelessWidget {
  final String title;
  final ExerciseStatus status;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ExerciseListTile({
    super.key,
    required this.title,
    this.status = ExerciseStatus.open,
    this.onTap,
    this.onDelete,
  });

  Color _statusColor(BuildContext context) {
    switch (status) {
      case ExerciseStatus.correct:
        return Colors.green;
      case ExerciseStatus.incorrect:
        return Colors.red;
      case ExerciseStatus.open:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          radius: 7,
          backgroundColor: _statusColor(context),
        ),
        title: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.open_in_new, size: 20),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
