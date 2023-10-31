import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ny_times_app/blocs/article_bloc.dart';
import 'package:ny_times_app/repositories/article_repository.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<ArticleRepository>(
      () => ArticleRepository(dio: GetIt.I<Dio>()));
  locator.registerLazySingleton<ArticleBloc>(() => ArticleBloc());
}
