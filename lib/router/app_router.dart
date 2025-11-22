import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quasar/models/event.dart';
import 'package:quasar/screens/contacts_screen.dart';
import 'package:quasar/screens/event_create_screen.dart';
import 'package:quasar/screens/event_detail_screen.dart';
import 'package:quasar/screens/event_list_screen.dart';
import 'package:quasar/screens/explore_screen.dart';
import 'package:quasar/screens/gallery_screen.dart';
import 'package:quasar/screens/login_screen.dart';
import 'package:quasar/screens/notification_screen.dart';
import 'package:quasar/screens/profile_screen.dart';
import 'package:quasar/services/auth_service.dart';
import 'package:quasar/widgets/app_bottom_nav_bar_widget.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final AuthService authService;

  AppRouter(this.authService);

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/events',
    redirect: (context, state) {
      final isSignedIn = authService.isSignedIn;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isSignedIn && !isLoginRoute) {
        return '/login';
      }

      if (isSignedIn && isLoginRoute) {
        return '/events';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(authService: authService),
      ),
      GoRoute(
        path: '/notifications',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const NotificationScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppBottomNavBarWidget(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/events',
                builder: (context, state) => const EventListScreen(),
                routes: [
                  GoRoute(
                    path: '/create',
                    builder: (context, state) => const EventCreateScreen(),
                  ),
                  GoRoute(
                    path: '/:id',
                    builder: (context, state) {
                      final event = state.extra as Event;
                      return EventDetailScreen(event: event);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/contacts',
                builder: (context, state) => const ContactsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/gallery',
                builder: (context, state) => const GalleryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
