import 'package:flutter/material.dart';
import 'package:frontend/widgets/shared/theme_button.dart';

class SmartLearnAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SmartLearnAppBar({
    // im Konstruktor entgegennehmen
    super.key,
    this.title = "SMARTLEARN",
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      elevation: 4,
      shadowColor: Colors.black,
      actions: [ThemeButton()],
    );
  }
}
