import 'package:frontend/core/app_shell.dart';
import 'package:frontend/screens/documents_screen.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    // Main application shell
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/documents',
              builder: (context, state) => const DocumentsScreen(),
            ),
          ],
        ),
      ],
    ),

    // Global routes (outside the shell)
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),

    // Authentication
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
  ],
);
