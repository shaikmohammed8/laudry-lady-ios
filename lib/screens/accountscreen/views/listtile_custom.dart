import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class ListTileCustom extends StatelessWidget {
  const ListTileCustom({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: ListTile(
        trailing: const Icon(
          FluentSystemIcons.ic_fluent_ios_chevron_right_regular,
          color: Themes.secondaryColor,
          size: 28,
        ),
        title: Text(
          title,
          style: Themes.bodyText,
        ),
        leading: Icon(
          icon,
          color: Themes.mainColor,
          size: 28,
        ),
        subtitle: Text(subtitle, style: Themes.overlayText),
      ),
    );
  }
}
