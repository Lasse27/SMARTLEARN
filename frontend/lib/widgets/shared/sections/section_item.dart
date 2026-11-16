import 'package:flutter/widgets.dart';

/// Ein einzelner Eintrag der Liste.
class SectionItem {
  const SectionItem({
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onTap;
}
