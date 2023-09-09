import 'package:go_router/go_router.dart';
import 'package:store_glimpse/preview/preview_page.dart';

GoRouter goRouter = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const PreviewPage()),
]);
