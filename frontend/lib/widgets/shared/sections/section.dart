import 'package:frontend/widgets/shared/sections/section_content.dart';
import 'package:material_ui/material_ui.dart';
import 'package:frontend/widgets/shared/sections/section_header.dart';
import 'package:frontend/widgets/shared/sections/section_item.dart';

/// Section mit Titel und Items.
class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.title,
    required this.items,
    this.iconData,
    this.emptyText = 'Keine Einträge vorhanden.',
  });

  final String title;
  final List<SectionItem> items;
  final IconData? iconData;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: title, iconData: iconData, actions: []),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(emptyText),
            )
          else
            SectionContent(items: items),
        ],
      ),
    );
  }
}
