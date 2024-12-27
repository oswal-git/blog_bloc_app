import 'package:blog_bloc_app/core/routes/routes_name.dart';
import 'package:blog_bloc_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_bloc_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_bloc_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_bloc_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_bloc_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_bloc_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:blog_bloc_app/features/splash_page.dart';
import 'package:go_router/go_router.dart';

// final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey(debugLabel: 'root');
// final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey(debugLabel: 'shell');

class GoRouterProvider {
  static final GoRouter router = GoRouter(
    // navigatorKey: _rootNavigatorKey,
    initialLocation: rootRoute,
    errorBuilder: (context, state) => LoginPage(key: state.pageKey),
    // redirect: (BuildContext context, GoRouterState goRouterState) {
    //   final bool isLoggedIn = context.watch<AppUserCubit>().state is AppUserLoggedInState;
    //   final bool isLoggingIn = goRouterState.uri.toString() == homeRoute;

    //   if (!isLoggedIn && !isLoggingIn) return homeRoute;
    //   if (isLoggedIn && isLoggingIn) return blogRoute;
    //   return null;
    // },
    routes: [
      GoRoute(
        path: rootRoute,
        builder: (context, state) => SplashPage(key: state.pageKey),
      ),
      GoRoute(
        path: homeRoute,
        builder: (context, state) => LoginPage(key: state.pageKey),
      ),
      GoRoute(
        path: loginRoute,
        builder: (context, state) => LoginPage(key: state.pageKey),
      ),
      GoRoute(
        path: signupRoute,
        builder: (context, state) => SignUpPage(key: state.pageKey),
      ),
      GoRoute(
        path: blogRoute,
        builder: (context, state) => BlogPage(key: state.pageKey),
      ),
      GoRoute(
        path: newBlogRoute,
        builder: (context, state) => AddNewBlogPage(key: state.pageKey),
      ),
      GoRoute(
        path: viewBlogRoute,
        builder: (context, state) {
          final blog = state.extra as BlogEntity;
          return BlogViewerPage(
            key: state.pageKey,
            blog: blog,
          );
        },
      ),
    ],
  );
}
