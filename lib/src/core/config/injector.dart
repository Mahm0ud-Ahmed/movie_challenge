import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:get_it/get_it.dart';
import 'package:movie_challange/src/core/services/hive_service.dart';
import 'package:movie_challange/src/core/utils/theme_manager.dart';
import 'package:movie_challange/src/data/local/app_database.dart';

import '../../data/remote/dio_api_service.dart';
import '../../presentation/view_model/blocs/assistance/my_bloc_observer.dart';
import '../../presentation/view_model/blocs/data_bloc/api_data_bloc.dart';
import '../services/dio_service.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  injector.registerSingleton<DioService>(DioService());
  await injector<DioService>().initializeService();

  injector.registerSingleton<HiveService>(HiveService());
  await injector<HiveService>().initializeService();

  injector.registerSingleton<DioApiService>(DioApiService(dio: injector<DioService>().dio));

  injector.registerSingleton<AppDatabase>(AppDatabase());

  injector.registerSingleton<ThemeManager>(ThemeManager());

  injector.registerFactory<ApiDataBloc>(() => ApiDataBloc());
  Bloc.observer = MyBlocObserver();
}
