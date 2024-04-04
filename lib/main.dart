import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_challange/src/presentation/view/pages/home/home_page.dart';

import 'src/core/config/injector.dart';
import 'src/core/config/l10n/generated/l10n.dart';
import 'src/core/utils/theme_manager.dart';
import 'src/presentation/view_model/blocs/data_bloc/api_data_bloc.dart';

void main() async {
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApiDataBloc>(
          create: (context) => injector<ApiDataBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: S.current.app_name,
        theme: ThemeManager.myTheme,
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          S.delegate,
          AppLocalizationDelegate(),
        ],
        home: const HomePage(),
      ),
    );
  }
}
