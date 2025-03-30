import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leyana/bloc/cubit/god_name/god_name_cubit.dart';
import 'package:leyana/bloc/cubit/verse/verse_cubit.dart';
import 'package:leyana/core/values.dart';
import 'package:leyana/models/setting_db_model.dart';
import 'package:leyana/router.dart';
import 'package:leyana/services/managers/settings_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:leyana/utils/logger.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // check dark mode (from db or system)
  final SettingDBModel isDarkModelInitial =
      await SettingsManager.getIsDarkModelInitial();

  final Directory directory = (await getDownloadsDirectory())!;
  logger.i("Directory Path: ${directory.path}");
  runApp(DevicePreview(
    enabled: !kReleaseMode && Config.kIsDevicePreview,
    tools: [
      ...DevicePreview.defaultTools,
      DevicePreviewScreenshot(
          multipleScreenshots: true,
          onScreenshot: screenshotAsFiles(directory)),
    ],
    builder: (context) => MyApp(
      isDarkModelInitial: isDarkModelInitial,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isDarkModelInitial});

  final SettingDBModel isDarkModelInitial;
  final bool _isInitialized = false;

  ThemeData _buildTheme(isDarkMode) {
    var baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.orangeAccent,
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
    return MultiBlocProvider(
        providers: [
          BlocProvider<VerseCubit>(
            create: (context) => VerseCubit(),
          ),
          BlocProvider<GodNameCubit>(
            create: (context) => GodNameCubit(),
          ),
        ],
        child: Builder(
          builder: (context) {
            // Initialize data once
            if (!_isInitialized) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<VerseCubit>().loadVerse();
                context.read<GodNameCubit>().loadRandomName();
              });
            }
            return StreamBuilder<List<SettingDBModel>>(
                stream: SettingsManager.listenToSetting(SettingName.isDarkMode),
                initialData: [isDarkModelInitial],
                builder: (context, snapshot) {
                  final bool isDarkMode =
                      snapshot.data?.firstOrNull?.value == "true";

                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    locale: DevicePreview.locale(context),
                    builder: DevicePreview.appBuilder,
                    supportedLocales: const [
                      Locale('ar'),
                    ],
                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    title: 'ليا انا',
                    theme: _buildTheme(isDarkMode),
                    routerConfig: router,
                  );
                });
          },
        ));
  }
}
