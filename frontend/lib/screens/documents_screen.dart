import 'package:frontend/models/document.dart';
import 'package:frontend/widgets/shared/lists/document_lists/document_list.dart';
import 'package:material_ui/material_ui.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        DocumentList(
          documents: [
            Document(
              id: "1",
              title: "Hello World",
              description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            Document(
              id: "2",
              title: "Hello World",
              description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            Document(
              id: "3",
              title: "Hello World",
              description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            Document(
              id: "4",
              title: "Hello World",
              description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            Document(
              id: "5",
              title: "Hello World",
              description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            Document(
              id: "6",
              title: "Hello World",
              description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            Document(
              id: "7",
              title: "Hello World",
              description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            Document(
              id: "8",
              title: "Hello World",
              description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
            Document(
              id: "9",
              title: "Hello World",
              description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
            ),
          ],
        ),
      ],
    );
  }
}
