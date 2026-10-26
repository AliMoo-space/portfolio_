import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/design_system/theme/theme_cubit.dart';
import 'package:portfolio/core/network/api_consumer.dart';
import 'package:portfolio/core/network/dio/dio_factory.dart';
import 'package:portfolio/core/network/dio_consumer.dart';
import 'package:portfolio/core/storage/local_storage.dart';
import 'package:portfolio/features/portfolio/data/repositories/projects_repository.dart';
import 'package:portfolio/features/portfolio/presentation/cubit/projects_cubit.dart';

final sl = GetIt.instance;

Future<void> init({SharedPreferences? preferences}) async {
  // =============================================
  // External Dependencies
  // =============================================
  final prefs = preferences ?? await SharedPreferences.getInstance();

  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerLazySingleton<SharedPreferences>(() => prefs);
  }

  // =============================================
  // Core Storage
  // =============================================
  if (!sl.isRegistered<LocalStorage>()) {
    sl.registerLazySingleton<LocalStorage>(
      () => LocalStorage(sl<SharedPreferences>()),
    );
  }

  // =============================================
  // Core Network
  // =============================================
  if (!sl.isRegistered<DioFactory>()) {
    sl.registerLazySingleton<DioFactory>(
      () => DioFactory(
        baseUrl: AppConstants.baseUrl,
        localStorage: sl<LocalStorage>(),
      ),
    );
  }

  if (!sl.isRegistered<Dio>()) {
    sl.registerLazySingleton<Dio>(
      () => sl<DioFactory>().create(),
    );
  }

  if (!sl.isRegistered<ApiConsumer>()) {
    sl.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(sl<Dio>()),
    );
  }

  // =============================================
  // Theme
  // =============================================
  if (!sl.isRegistered<ThemeCubit>()) {
    sl.registerLazySingleton<ThemeCubit>(
      () => ThemeCubit(),
    );
  }

  // =============================================
  // Portfolio Feature
  // =============================================
  if (!sl.isRegistered<ProjectsRepository>()) {
    sl.registerLazySingleton<ProjectsRepository>(
      () => ProjectsRepository(apiConsumer: sl<ApiConsumer>()),
    );
  }

  if (!sl.isRegistered<ProjectsCubit>()) {
    sl.registerFactory<ProjectsCubit>(
      () => ProjectsCubit(repository: sl<ProjectsRepository>()),
    );
  }
}
