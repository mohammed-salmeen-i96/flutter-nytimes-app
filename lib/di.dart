// di.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ny_times_app/main.dart';
import 'package:ny_times_app/repositories/article_repository.dart';
import 'blocs/article_bloc.dart';

void setup() {
  GetIt.I.registerSingleton<Dio>(Dio());
  GetIt.I.registerSingleton<ArticleRepository>(
      ArticleRepository(dio: GetIt.I<Dio>()));
  GetIt.I.registerFactory<ArticleBloc>(() => ArticleBloc());
}
