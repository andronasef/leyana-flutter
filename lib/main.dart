import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leyana/models/setting_db_model.dart';
import 'package:leyana/services/managers/settings_manager.dart';

import 'package:leyana/ui/screens/intro/intro_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:leyana/ui/screens/main/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool isIntroDone =
      await SettingsManager.getSetting(SettingName.isIntroDone) == "true";

  runApp(MyApp(
    isIntroDone: isIntroDone,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isIntroDone});

  final bool isIntroDone;

  ThemeData _buildTheme(isDarkMode) {
    var baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.notoSansArabicTextTheme(baseTheme.textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SettingDBModel>>(
        stream: SettingsManager.listenToSetting(SettingName.isDarkMode),
        builder: (context, snapshot) {
          final bool isDarkMode = snapshot.data?.firstOrNull?.value == "true";

          return MaterialApp(
            supportedLocales: const [
              Locale('ar'), // English
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            title: 'ليا انا',
            theme: _buildTheme(isDarkMode),
            initialRoute: isIntroDone ? "/" : "/intro",
            routes: {
              '/': (context) => const MainScreen(),
              '/intro': (context) => const IntroScreen(),
            },
          );
        });
  }
}
