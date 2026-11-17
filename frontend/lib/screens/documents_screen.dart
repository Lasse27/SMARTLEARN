import 'package:material_ui/material_ui.dart';

import '../../components/navigation/app_header.dart';
import '../../components/scan/scan_preview_card.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final List<String> _scans = ['Aufgabenblatt 1', 'Aufgabenblatt 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Aufgaben einscannen',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Name der Aufgabe',
              prefixIcon: Icon(Icons.title),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          ..._scans.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ScanPreviewCard(
                label: entry.value,
                preview: Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Center(
                    child: Icon(Icons.document_scanner_outlined, size: 56),
                  ),
                ),
                onEdit: () {},
                onRemove: () {
                  setState(() {
                    _scans.removeAt(entry.key);
                  });
                },
              ),
            ),
          ),

          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _scans.add('Aufgabenblatt ${_scans.length + 1}');
              });
            },
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text('Weitere Seite scannen'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.check),
      ),
    );
  }
}
