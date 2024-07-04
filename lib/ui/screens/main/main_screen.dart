import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leyana/ui/views/favorites/favorites_view.dart';
import 'package:leyana/ui/views/home/home_view.dart';
import 'package:leyana/ui/views/settings/settings_view.dart';
import 'package:animations/animations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScreen> {
  int _selectedIndex = kDebugMode ? 0 : 0;

  final List<Widget> pageList = [
    const HomeView(),
    const FavoritesView(),
    const SettingsView()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: pageList[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.article),
              icon: Icon(Icons.article_outlined),
              label: 'ايه اليوم',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.star),
              icon: Icon(Icons.star_outline),
              label: 'الايات المفضله',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'الاعدادات',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (selectedIndex) {
            setState(() => _selectedIndex = selectedIndex);
          },
        ),
      ),
    );
  }
}
