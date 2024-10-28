import 'package:auto_route/auto_route.dart';
import 'package:example_flutter_app/config/app_config.dart';
import 'package:example_flutter_app/injection/di.dart';
import 'package:example_flutter_app/presentation/cubit/cubit/auth_cubit.dart';
import 'package:example_flutter_app/presentation/navigation/app_router.dart';
import 'package:example_flutter_app/presentation/pages/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _splashCubit = getIt<SplashCubit>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _initialize();
    });
  }

  Future<void> _initialize() async {
    await getIt<AppConfig>().init();

    await getIt<AuthCubit>().init();
    if (getIt<AuthCubit>().state == const AuthState.unauthenticated()) {
      await getIt<AppRouter>().replace(const LoginRoute());
    } else {
      await _navigateToNextScreen();
    }
  }

  Future<void> _navigateToNextScreen() async {
    if (_splashCubit.isFirstTimeLaunch) {
      // Navigate to Onboarding Screen
      await getIt<AppRouter>().replace(const MainAppRoute());
    } else {
      await getIt<AppRouter>().replace(const MainAppRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
