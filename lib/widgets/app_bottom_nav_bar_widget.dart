import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavBarWidget extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppBottomNavBarWidget({super.key, required this.navigationShell});

  @override
  State<AppBottomNavBarWidget> createState() => _AppBottomNavBarWidgetState();
}

class _AppBottomNavBarWidgetState extends State<AppBottomNavBarWidget> {
  DateTime? _lastBackPressTime;
  final List<int> _navigationHistory = [0];

  void _onItemTapped(int index) {
    if (index != widget.navigationShell.currentIndex) {
      _navigationHistory.add(index);
    }

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  Future<bool> _onWillPop() async {
    if (_navigationHistory.length > 1) {
      _navigationHistory.removeLast();
      final previousIndex = _navigationHistory.last;
      widget.navigationShell.goBranch(previousIndex);
      return false;
    }

    final now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '한번 더 뒤로가기를 시도할 경우 종료됩니다.',
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
      return false;
    }

    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.navigationShell.currentIndex;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        await _onWillPop();
      },
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: _onItemTapped,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          height: 50,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.contacts_outlined),
              selectedIcon: Icon(Icons.contacts),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.photo_library_outlined),
              selectedIcon: Icon(Icons.photo_library),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
