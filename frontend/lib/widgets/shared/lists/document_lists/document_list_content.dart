import 'package:frontend/models/document.dart';
import 'package:frontend/widgets/shared/lists/document_lists/document_list_item.dart';
import 'package:material_ui/material_ui.dart';

class DocumentListContent extends StatelessWidget {
  const DocumentListContent({super.key, required this.documents});
  final List<Document> documents;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: documents.length,
      separatorBuilder: (_, _) => Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (context, index) => DocumentListItem(item: documents[index]),
    );
  }
}
