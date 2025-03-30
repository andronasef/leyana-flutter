import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leyana/bloc/cubit/god_name/god_name_cubit.dart';
import 'package:leyana/bloc/cubit/verse/verse_cubit.dart';
import 'package:leyana/services/managers/settings_manager.dart';
import 'package:leyana/ui/screens/content/god_name_detail_screen.dart';
import 'package:leyana/ui/screens/intro/intro_screen.dart';
import 'package:leyana/ui/screens/main/main_screen.dart';
import 'package:leyana/ui/screens/settings/profile_settings_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (context, state) async {
        final bool isIntroDone =
            await SettingsManager.getSetting(SettingName.isIntroDone) == "true";
        return isIntroDone ? '/homepage' : null;
      },
      builder: (BuildContext context, GoRouterState state) {
        return const IntroScreen();
      },
    ),
    GoRoute(
      path: '/homepage',
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      path: '/settings/profile',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileSettingsScreen();
      },
    ),
    GoRoute(
      path: '/god-name/:id',
      builder: (BuildContext context, GoRouterState state) {
        final nameId = state.pathParameters['id']!;
        return GodNameDetailScreen(nameId: nameId);
      },
    ),
  ],
);
