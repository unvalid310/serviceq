import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:serviceq/data/repository/bengkel_repo.dart';
import 'package:serviceq/data/repository/favorit_repo.dart';
import 'package:serviceq/data/repository/filter_repo.dart';
import 'package:serviceq/data/repository/history_repo.dart';
import 'package:serviceq/data/repository/language_repo.dart';
import 'package:serviceq/data/repository/lokasi_repo.dart';
import 'package:serviceq/data/repository/rating_repo.dart';
import 'package:serviceq/data/repository/rekomendasi_repo.dart';
import 'package:serviceq/data/repository/sparepart_repo.dart';
import 'package:serviceq/data/repository/tipe_bengkel_repo.dart';
import 'package:serviceq/data/repository/ulasan_repo.dart';
import 'package:serviceq/provider/auth_provider.dart';
import 'package:serviceq/provider/bengkel_provider.dart';
import 'package:serviceq/provider/favorit_provider.dart';
import 'package:serviceq/provider/filter_provider.dart';
import 'package:serviceq/provider/history_provider.dart';
import 'package:serviceq/provider/language_provider.dart';
import 'package:serviceq/provider/localization_provider.dart';
import 'package:serviceq/provider/lokasi_provider.dart';
import 'package:serviceq/provider/rating_provider.dart';
import 'package:serviceq/provider/rekomendasi_provider.dart';
import 'package:serviceq/provider/sparepart_provider.dart';
import 'package:serviceq/provider/theme_provider.dart';
import 'package:serviceq/provider/tipe_bengkel_provider.dart';
import 'package:serviceq/provider/ulasan_provider.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/auth_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());

  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => LanguageRepo());
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => BengkelRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => RekomendasiRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => TipeBengkelRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => FilterRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => HistoryRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => UlasanRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => RatingRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => LokasiRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => SparepartRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => FavoritRepo(dioClient: sl(), sharedPreferences: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => BengkelProvider(bengkelRepo: sl()));
  sl.registerFactory(() => LokasiProvider(lokasiRepo: sl()));
  sl.registerFactory(() => SparepartProvider(sparepartRepo: sl()));
  sl.registerFactory(() => FavoritProvider(favoritRepo: sl()));
  sl.registerFactory(() => RekomendasiProvider(rekomendasiRepo: sl()));
  sl.registerFactory(
      () => HistoryProvider(historyRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(() => TipeBengkelProvider(tipeBengkelRepo: sl()));
  sl.registerFactory(
      () => FilterProvider(filterRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => UlasanProvider(ulasanRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => RatingProvider(ratingRepo: sl(), sharedPreferences: sl()));
}
