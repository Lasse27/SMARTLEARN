import 'package:material_ui/material_ui.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onProfile;

  const AppHeader({
    super.key,
    required this.title,
    this.onBack,
    this.onProfile,
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
              icon: const Icon(Icons.arrow_back_ios_new, size: 19),
              onPressed: onBack,
            ),
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: onProfile,
        ),
      ],
    );
  }
}
