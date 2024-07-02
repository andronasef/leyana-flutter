import 'package:flutter/material.dart';
import 'package:leyana/ui/screens/intro/intro_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:leyana/ui/screens/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: true ? "/intro" : "/",
      routes: {
        '/': (context) => const MainScreen(),
        '/intro': (context) => const IntroScreen(),
      },
    );
  }
}
