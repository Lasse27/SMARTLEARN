import 'package:material_ui/material_ui.dart';
import 'package:frontend/models/document.dart';

import 'document_list_content.dart';

/// Eine durchsuchbare Liste gescannter Dokumente.
class DocumentList extends StatelessWidget {
  const DocumentList({super.key, required this.documents});

  /// Alle verfügbaren Dokumente.
  final List<Document> documents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [DocumentListContent(documents: documents)],
    );
  }
}
