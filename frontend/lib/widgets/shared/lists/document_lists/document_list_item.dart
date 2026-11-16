import 'package:frontend/models/document.dart';
import 'package:material_ui/material_ui.dart';

/// Widget zur Darstellung eines einzelnen Dokuments in einer Liste.
class DocumentListItem extends StatelessWidget {
  const DocumentListItem({super.key, required this.item});

  final Document item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.description_outlined),
      title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        item.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            tooltip: 'Öffnen',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Herunterladen',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Löschen',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
