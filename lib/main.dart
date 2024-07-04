import 'package:flutter/material.dart';
import 'package:leyana/services/managers/settings_manager.dart';

import 'package:leyana/ui/screens/intro/intro_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:leyana/ui/screens/main/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isIntroDone =
      await SettingsManager.getSetting(SettingName.isIntroDone) == "true"
          ? true
          : false;

  runApp(MyApp(
    isIntroDone: isIntroDone,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isIntroDone});

  final bool isIntroDone;

  @override
  Widget build(BuildContext context) {
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      initialRoute: isIntroDone ? "/" : "/intro",
      routes: {
        '/': (context) => const MainScreen(),
        '/intro': (context) => const IntroScreen(),
      },
    );
  }
}
