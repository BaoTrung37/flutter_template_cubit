import 'package:example_flutter_app/config/app_config.dart';
import 'package:example_flutter_app/config/constants/app_constants.dart';
import 'package:example_flutter_app/config/theme/app_theme.dart';
import 'package:example_flutter_app/injection/di.dart';
import 'package:example_flutter_app/l10n/app_localizations.dart';
import 'package:example_flutter_app/presentation/app/cubit/app_cubit.dart';
import 'package:example_flutter_app/presentation/cubit/cubit/auth_cubit.dart';
import 'package:example_flutter_app/presentation/navigation/app_router.dart';
import 'package:example_flutter_app/presentation/utilities/enums/common/languages.dart';
import 'package:example_flutter_app/presentation/utilities/logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    AppLogger.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstants.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: child,
      ),
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (contExt) => getIt<AppCubit>(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => getIt<AuthCubit>(),
        ),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        bloc: getIt<AuthCubit>(),
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            unauthenticated: () {
              getIt<AppRouter>().replace(const LoginRoute());
            },
          );
        },
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) =>
              previous.currentLanguage != current.currentLanguage,
          builder: (context, state) {
            return MaterialApp.router(
              title: getIt<AppConfig>().title,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: getThemeData(Brightness.light),
              locale: state.currentLanguage.locate,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: getIt<AppRouter>().config(),
              builder: EasyLoading.init(),
            );
          },
        ),
      ),
    );
  }
}
