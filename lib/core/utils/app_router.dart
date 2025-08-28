import 'package:go_router/go_router.dart';

import '../../feature/home/presentation/view/home_view.dart';


abstract class AppRouter {
  static const kHomeView = '/home';
  static final router = GoRouter(
    routes: [GoRoute(path: '/', builder: (context, state) => const HomeView())],
  );
}
