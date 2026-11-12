import 'package:flutter/material.dart';
import 'package:frontend/core/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeButton extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 32,
      tooltip: "Toggle theme",
      onPressed: () {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final mode = isDark ? ThemeMode.light : ThemeMode.dark;
        context.read<ThemeProvider>().setThemeMode(mode);
      },
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
    );
  }
}
