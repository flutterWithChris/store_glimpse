import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_glimpse/auth/bloc/auth_bloc.dart';
import 'package:store_glimpse/landing/landing_page.dart';
import 'package:store_glimpse/login/view/login_page.dart';
import 'package:store_glimpse/onboarding/view/onboarding_page.dart';
import 'package:store_glimpse/preview/preview_page.dart';

GoRouter goRouter = GoRouter(
    redirect: (context, state) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn =
          context.read<AuthBloc>().state.status == AuthStatus.authenticated;

      bool isLoggingIn = state.uri.pathSegments.contains('login');
      bool isOnboarding = state.uri.pathSegments.contains('onboarding');
      bool completedOnboarding = prefs.getBool('completedOnboarding') ?? false;

      if (completedOnboarding == false) {
        if (isOnboarding) {
          return null;
        } else {
          return '/onboarding';
        }
      }

      if (isLoggedIn == false) {
        if (isLoggingIn) {
          return null;
        } else {
          return '/login';
        }
      }

      return null;
    },
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const PreviewPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
          path: '/success', builder: (context, state) => const LandingPage()),
      GoRoute(
          path: '/cancel', builder: (context, state) => const LandingPage()),
    ]);
