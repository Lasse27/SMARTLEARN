import 'package:material_ui/material_ui.dart';
import 'package:frontend/widgets/shared/sections/section_item.dart';

class SectionContent extends StatelessWidget {
  const SectionContent({super.key, required this.items});
  final List<SectionItem> items;
  
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, _) => Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: item.icon != null ? Icon(item.icon) : null,

          // Titel des Items
          title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),

          // Untertitel/Beschreibung des Items
          subtitle: item.subtitle != null
              ? Text(
                  item.subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: item.onTap != null ? const Icon(Icons.chevron_right) : null,
          onTap: item.onTap,
        );
      },
    );
  }
}
