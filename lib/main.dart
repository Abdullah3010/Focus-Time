import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/config/app_config.dart';
import 'package:focus_time/config/themes/app_dark_theme.dart';
import 'package:focus_time/config/themes/app_light_theme.dart';
import 'package:focus_time/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:focus_time/features/auth/presentation/screens/login_screen.dart';
import 'package:focus_time/features/groups/presentation/bloc/usecases_bloc/group_usecases_bloc.dart';
import 'package:focus_time/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:focus_time/features/home/presentation/screens/home_screen.dart';
import 'package:focus_time/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:focus_time/features/settings/presentation/bloc/settings_bloc/settings_bloc.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:focus_time/features/tasks/presentation/bloc/tasks_pages/tasks_bloc.dart';
import 'package:focus_time/injector.dart';
import 'package:focus_time/observer.dart';
import 'package:focus_time/test_screen.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MyInjector.injector<AuthBloc>()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => TasksBloc()),
        BlocProvider(create: (_) => MyInjector.injector<TaskUsecasesBloc>()),
        BlocProvider(create: (_) => MyInjector.injector<ProfileBloc>()),
        BlocProvider(create: (_) => MyInjector.injector<GroupUsecasesBloc>()),
        BlocProvider(create: (_) => SettingsBloc()),
      ],
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          Widget? screen;
          if (snapshot.data == null) {
            screen = LoginScreen();
          } else {
            screen = HomeScreen();
          }
          return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<SettingsBloc>(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                // routes: {
                //   '/test': (context) => const TestScreen(),
                // },
                title: 'Focus Time',
                theme: appLightTheme,
                darkTheme: appDarkTheme,
                themeMode: bloc.themeMode,
                home: screen,
              );
            },
          );
        },
      ),
    );
  }
}
