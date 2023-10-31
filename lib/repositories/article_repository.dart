// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ny_times_app/config/app_config.dart';
import 'package:ny_times_app/models/article_model.dart';

class ArticleRepository {
  final Dio _dio;

  ArticleRepository({Dio? dio}) : _dio = GetIt.instance<Dio>();

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await _dio.get(AppConfig.BASE_URL + AppConfig.API_KEY);
      // print(response);
      if (response.data != null && response.data['results'] != null) {
        return (response.data['results'] as List)
            .map((json) => Article.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load articles from the server');
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 429) {
        print('Rate limit exceeded. Please wait before making more requests.');
      } else {
        print('Dio error: ${e.message}');
      }

      throw Exception(
          'Failed to fetch articles. Please check your connection.');
    } catch (e) {
      print('General error: $e');
      throw Exception('An unknown error occurred while fetching articles.');
    }
  }
}
