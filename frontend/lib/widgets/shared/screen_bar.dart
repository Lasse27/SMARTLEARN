import 'package:material_ui/material_ui.dart';

class ScreenBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const ScreenBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      leading: onBack == null
          ? null
          : IconButton(
              icon: const Icon(Icons.chevron_left, size: 19),
              onPressed: onBack,
            ),
    );
  }
}
