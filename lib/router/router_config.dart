import 'package:go_router/go_router.dart';
import 'package:sign_in_by_apple_id/screens/login_screen/login_screen.dart';
import 'package:sign_in_by_apple_id/screens/password_screen/password_screen.dart';

class Routes {
  static final router = GoRouter(
    initialLocation: login,
    debugLogDiagnostics: true,
    redirectLimit: 10,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: 'password',
            builder: (context, state) => const PasswordScreen(),
          ),
        ],
      ),
    ],
  );

  static const login = '/';
  static const password = '/password';
}
