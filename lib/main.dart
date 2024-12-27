import 'package:blog_bloc_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blog_bloc_app/core/routes/go_router_provider.dart';
import 'package:blog_bloc_app/core/theme/app_theme.dart';
import 'package:blog_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_bloc_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_bloc_app/ini_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await iniDependences();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AppUserCubit>(
        create: (context) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider<AuthBloc>(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider<BlogBloc>(
        create: (context) => serviceLocator<BlogBloc>(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouterProvider.router;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      routerConfig: goRouter,
    );
  }
}
