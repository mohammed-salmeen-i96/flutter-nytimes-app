import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ny_times_app/repositories/article_repository.dart';
import 'package:ny_times_app/blocs/article_bloc.dart'; // Assuming you've the ArticleBloc in this location
import 'package:ny_times_app/screens/ArticleListScreen.dart';

// final sl = GetIt.instance;

void setupLocator() {
  GetIt.I.registerLazySingleton(() => Dio()); // Registering Dio
  GetIt.I.registerLazySingleton(
    () =>
        ArticleRepository(dio: GetIt.I<Dio>()), // Registering ArticleRepository
  );
  GetIt.I.registerFactory(() => ArticleBloc()); // Registering ArticleBloc
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<ArticleBloc>(
        create: (context) => GetIt.I<ArticleBloc>(),
        child: Scaffold(
          body: ArticleListScreen(),
        ),
      ),
    );
  }
}
