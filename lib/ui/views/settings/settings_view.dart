import 'package:flutter/material.dart';
import 'package:leyana/models/setting_db_model.dart';
import 'package:leyana/services/managers/settings_manager.dart';
import 'package:leyana/ui/views/settings/widgets/settings_section_title.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsSectionTitle("الاعدادات الرئيسية"),
          SizedBox(height: 8),
          Material(
            child: StreamBuilder<List<SettingDBModel>>(
                stream: SettingsManager.listenToSetting(SettingName.isDarkMode),
                builder: (context, snapshot) {
                  final bool isDarkMode =
                      snapshot.data?.firstOrNull?.value == "true";
                  return SwitchListTile(
                    value: isDarkMode,
                    title: Text("الوضع الليلي",
                        style: Theme.of(context).textTheme.titleMedium),
                    onChanged: (value) async {
                      await SettingsManager.setSetting(
                          SettingName.isDarkMode, value.toString());
                    },
                  );
                }),
          ),
          // TODO: Implement Local Notifications
          // Material(
          //     child: ListTile(
          //   title: Text(
          //     "معاد التنبيه اليومي",
          //     style: Theme.of(context).textTheme.titleMedium,
          //   ),
          //   trailing: Text(
          //     "8:00 AM",
          //     textDirection: TextDirection.ltr,
          //     style: Theme.of(context).textTheme.titleMedium,
          //   ),
          //   onTap: () {},
          // )),
          SizedBox(height: 16),
          SettingsSectionTitle("المزيد"),
          SizedBox(height: 8),
          const SettingLinkItem(
            text: "قيم التطبيق",
            icon: Icons.star,
            link: "",
          ),
          const SettingLinkItem(
            text: "شارك التطبيق",
            icon: Icons.share,
            link: "",
          ),
          const SettingLinkItem(
            text: "اطلب ميزة جديدة",
            icon: Icons.emoji_objects,
            link: "",
          ),
          const SettingLinkItem(
            text: "سياسة الخصوصية",
            icon: Icons.privacy_tip,
            link: "",
          ),
          const SettingLinkItem(
            text: "اتواصل معانا",
            icon: Icons.phone,
            link: "",
          ),
        ],
      ),
    );
  }
}

class SettingLinkItem extends StatelessWidget {
  const SettingLinkItem(
      {super.key, required this.icon, required this.text, required this.link});

  final IconData icon;
  final String text;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListTile(
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Icon(icon),
      onTap: () {
        // launchUrl(_url)) using url_launcher
      },
    ));
  }
}
