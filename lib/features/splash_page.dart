import 'package:blog_bloc_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blog_bloc_app/core/routes/go_router_provider.dart';
import 'package:blog_bloc_app/core/routes/routes_name.dart';
import 'package:blog_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_bloc_app/ini_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouterProvider.router;
    final appUserCubit = serviceLocator<AppUserCubit>(); // Usando un Service Locator o inyección de dependencias

    Future.delayed(const Duration(seconds: 3), () {
      final bool appUserLoggedInState = appUserCubit.state is AppUserLoggedInState;

      if (appUserLoggedInState) {
        // Navega a la página de Blog si está autenticado
        goRouter.go(blogRoute);
      } else {
        // Navega a la página de Login si no está autenticado
        goRouter.go(loginRoute);
      }
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
