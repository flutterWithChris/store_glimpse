import 'package:go_router/go_router.dart';
import 'package:store_glimpse/landing/landing_page.dart';
import 'package:store_glimpse/login/view/login_page.dart';
import 'package:store_glimpse/preview/preview_page.dart';

GoRouter goRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/preview',
    builder: (context, state) => const PreviewPage(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/',
    builder: (context, state) => const LandingPage(),
  )
]);
