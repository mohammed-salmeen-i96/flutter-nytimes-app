import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/article_model.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  ArticleDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Details'),
        backgroundColor: const Color.fromRGBO(147, 223, 196, 1),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(article.byline),
            SizedBox(height: 8),
            Text('For more details, visit: ${article.url}'),
          ],
        ),
      ),
    );
  }
}
