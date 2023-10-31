import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
// import 'package:ny_times_app/main.dart'; // Ensure this import doesn't create circular dependencies
import 'package:ny_times_app/models/article_model.dart';
import 'package:ny_times_app/repositories/article_repository.dart';

class ArticleBloc extends Cubit<List<Article>> {
  // Using GetIt to get the instance of ArticleRepository
  final ArticleRepository repository = GetIt.I<ArticleRepository>();

  ArticleBloc() : super([]);

  fetchArticles() async {
    try {
      // fetching and emitting articles
      emit(await repository.fetchArticles());
    } catch (e) {
      // handling the error
      print("error fetching articles $e");
    }
  }
}
