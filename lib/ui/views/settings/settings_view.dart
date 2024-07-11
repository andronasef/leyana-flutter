import 'package:flutter/material.dart';
import 'package:leyana/core/values.dart';
import 'package:leyana/models/setting_db_model.dart';
import 'package:leyana/services/local_notify_service.dart';
import 'package:leyana/services/managers/settings_manager.dart';
import 'package:leyana/ui/views/settings/widgets/setting_list_item.dart';
import 'package:leyana/ui/views/settings/widgets/settings_section_title.dart';
import 'package:share_plus/share_plus.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SettingsSectionTitle("الاعدادات الرئيسية"),
                const SizedBox(height: 8),
                Material(
                  child: StreamBuilder<List<SettingDBModel>>(
                      stream: SettingsManager.listenToSetting(
                          SettingName.isDarkMode),
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
                Builder(builder: (context) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: Material(
                        child: StreamBuilder<List<SettingDBModel>>(
                            stream: SettingsManager.listenToSetting(
                                SettingName.notificationTime),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Container();
                              }

                              final timeText =
                                  snapshot.data?.firstOrNull?.value ?? "9:00 ص";

                              final parsedTime = TimeOfDay(
                                hour: int.parse(timeText.split(":")[0]),
                                minute: int.parse(
                                    timeText.split(":")[1].split(" ")[0]),
                              );

                              return ListTile(
                                title: Text(
                                  "معاد التنبيه اليومي",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                trailing: Text(
                                  timeText,
                                  textDirection: TextDirection.ltr,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                onTap: () async {
                                  TimeOfDay? timeOfDay = await showTimePicker(
                                    context: context,
                                    initialTime: parsedTime,
                                    builder: (context, child) => MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: false),
                                        child: child!),
                                  );

                                  if (timeOfDay == null) return;

                                  await SettingsManager.setSetting(
                                      SettingName.notificationTime,
                                      timeOfDay.format(context));
                                  await LocalNotifyService
                                      .updateScheduledNotification(
                                          LocalNotifysList
                                              .customDailyNotification(
                                                  timeOfDay));
                                },
                              );
                            })),
                  );
                }),
                const SizedBox(height: 16),
                const SettingsSectionTitle("المزيد"),
                const SizedBox(height: 8),
                const SettingLinkItem(
                  text: "قيم التطبيق",
                  icon: Icons.star,
                  link: AppUrls.rate,
                ),
                SettingLinkItem(
                  text: "شارك التطبيق",
                  icon: Icons.share,
                  action: () async {
                    Share.share(AppUrls.share);
                  },
                ),
                const SettingLinkItem(
                  text: "اطلب ميزة جديدة",
                  icon: Icons.emoji_objects,
                  link: AppUrls.support,
                ),
                const SettingLinkItem(
                  text: "بلغ عن مشكلة",
                  icon: Icons.error,
                  link: AppUrls.support,
                ),
                const SettingLinkItem(
                  text: "سياسة الخصوصية",
                  icon: Icons.privacy_tip,
                  link: AppUrls.privacy,
                ),
                const SettingLinkItem(
                  text: "اتواصل معانا",
                  icon: Icons.phone,
                  link: AppUrls.contact,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
