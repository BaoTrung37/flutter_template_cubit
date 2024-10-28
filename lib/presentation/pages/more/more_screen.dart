import 'package:auto_route/auto_route.dart';
import 'package:example_flutter_app/injection/di.dart';
import 'package:example_flutter_app/presentation/app/cubit/app_cubit.dart';
import 'package:example_flutter_app/presentation/cubit/cubit/auth_cubit.dart';
import 'package:example_flutter_app/presentation/navigation/app_router.dart';
import 'package:example_flutter_app/presentation/utilities/enums/common/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('More Screen'),
            BlocBuilder<AppCubit, AppState>(
              bloc: getIt<AppCubit>()..init(),
              builder: (context, state) {
                return DropdownButton<Languages>(
                  items: Languages.values
                      .map(
                        (language) => DropdownMenuItem(
                          value: language,
                          child: Text(language.name),
                        ),
                      )
                      .toList(),
                  value: state.currentLanguage,
                  onChanged: (value) {
                    getIt<AppCubit>().changeLanguage(value!);
                  },
                );
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              bloc: getIt<AuthCubit>(),
              listener: (context, state) {
                state.maybeMap(
                  orElse: () {},
                  unauthenticated: (_) {
                    context.router.replace(const LoginRoute());
                  },
                );
              },
              child: TextButton(
                onPressed: () {
                  getIt<AuthCubit>().logout();
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
