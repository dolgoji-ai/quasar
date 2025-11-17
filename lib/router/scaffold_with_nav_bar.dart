import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  void _onItemTapped(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;
    final shouldHideNavBar = currentIndex == 2;

    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(child: navigationShell),
          if (!shouldHideNavBar)
            CupertinoTabBar(
              iconSize: 24,
              currentIndex: currentIndex,
              onTap: (index) => _onItemTapped(context, index),
              items: const [
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.house)),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.globe)),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled)),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.photo_on_rectangle),
                ),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_circle)),
              ],
            ),
        ],
      ),
    );
  }
}
