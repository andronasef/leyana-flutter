import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingLinkItem extends StatelessWidget {
  const SettingLinkItem(
      {super.key,
      required this.icon,
      required this.text,
      this.link,
      this.action});

  final IconData icon;
  final String text;
  final String? link;
  final Function? action;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListTile(
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Icon(icon),
      onTap: () async {
        if (link != null &&
            link!.isNotEmpty &&
            await canLaunchUrlString(link!)) {
          await launchUrlString(link!);
        }
        if (action != null) {
          action!();
        }
      },
    ));
  }
}
