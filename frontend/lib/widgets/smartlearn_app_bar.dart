import 'package:flutter/material.dart';

class SmartLearnAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showProfileButton;

  const SmartLearnAppBar({
    // im Konstruktor entgegennehmen
    super.key,
    this.title = "SMARTLEARN",
    this.showProfileButton = true,
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
      automaticallyImplyLeading: false,
    );
  }
}
