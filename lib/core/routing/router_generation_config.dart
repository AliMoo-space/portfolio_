import 'package:go_router/go_router.dart';
import 'package:portfolio/core/routing/app_routes.dart';
import 'package:portfolio/core/routing/page_transition.dart';
import 'package:portfolio/features/portfolio/presentation/screens/home_page.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        name: AppRoutes.home,
        path: AppRoutes.home,
        pageBuilder: (context, state) =>
            fadeTransitionPage(state: state, child: const HomePage()),
      ),
    ],
  );
}
