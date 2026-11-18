import 'package:material_ui/material_ui.dart';

class ScanPreviewCard extends StatelessWidget {
  final String label;
  final Widget? preview;
  final VoidCallback? onRemove;
  final VoidCallback? onEdit;

  const ScanPreviewCard({
    super.key,
    required this.label,
    this.preview,
    this.onRemove,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (preview != null)
            SizedBox(height: 170, child: preview)
          else
            const SizedBox(
              height: 170,
              child: Center(child: Icon(Icons.image_outlined, size: 48)),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            child: Row(
              children: [
                Expanded(child: Text(label)),
                if (onEdit != null)
                  IconButton(
                    tooltip: 'Bearbeiten',
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: onEdit,
                  ),
                if (onRemove != null)
                  IconButton(
                    tooltip: 'Entfernen',
                    icon: const Icon(Icons.close),
                    onPressed: onRemove,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
