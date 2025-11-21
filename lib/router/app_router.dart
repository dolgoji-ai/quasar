import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/event_list_page.dart';
import '../screens/explore_page.dart';
import '../screens/contacts_page.dart';
import '../screens/gallery_page.dart';
import '../screens/profile_page.dart';
import '../screens/create_page.dart';
import '../screens/event_detail_page.dart';
import '../screens/event_create_page.dart';
import '../screens/login_page.dart';
import '../services/auth_service.dart';
import '../models/event.dart';
import 'scaffold_with_nav_bar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final AuthService authService;

  AppRouter(this.authService);

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    redirect: (context, state) {
      final isSignedIn = authService.isSignedIn;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isSignedIn && !isLoginRoute) {
        return '/login';
      }

      if (isSignedIn && isLoginRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(authService: authService),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const EventListContent(),
                routes: [
                  GoRoute(
                    path: 'event/:id',
                    builder: (context, state) {
                      final event = state.extra as Event;
                      return EventDetailPage(event: event);
                    },
                  ),
                  GoRoute(
                    path: 'event-create',
                    builder: (context, state) => const EventCreatePage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExplorePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/contacts',
                builder: (context, state) => const ContactsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/create',
                builder: (context, state) => const CreatePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/gallery',
                builder: (context, state) => const GalleryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
