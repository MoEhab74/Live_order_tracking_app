import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:practical_google_maps_example/core/routing/app_routes.dart';
import 'package:practical_google_maps_example/core/utils/service_locator.dart';
import 'package:practical_google_maps_example/features/auth/cubit/auth_cubit.dart';
import 'package:practical_google_maps_example/features/auth/login_screen.dart';
import 'package:practical_google_maps_example/features/auth/register_screen.dart';
import 'package:practical_google_maps_example/features/home/home_screen.dart';
import 'package:practical_google_maps_example/features/splash_screen/splash_screen.dart';

class RouterGenerationConfig {
  static GoRouter goRouter =
      GoRouter(initialLocation: AppRoutes.splashScreen, routes: [
    GoRoute(
      name: AppRoutes.splashScreen,
      path: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: AppRoutes.loginScreen,
      path: AppRoutes.loginScreen,
      builder: (context, state) => BlocProvider(
          create: (context) => sl<AuthCubit>(), child: const LoginScreen()),
    ),
    GoRoute(
      name: AppRoutes.registerScreen,
      path: AppRoutes.registerScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: const RegisterScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.homeScreen,
      path: AppRoutes.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
  ]);
}
