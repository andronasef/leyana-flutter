import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leyana/bloc/cubit/verse/verse_cubit.dart';
import 'package:leyana/services/managers/settings_manager.dart';
import 'package:leyana/ui/screens/intro/intro_screen.dart';
import 'package:leyana/ui/screens/main/main_screen.dart';

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
        context.read<VerseCubit>().loadVerse();
        return const MainScreen();
      },
    ),
  ],
);
