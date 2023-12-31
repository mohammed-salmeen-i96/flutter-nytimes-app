import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ny_times_app/locator.dart';
import 'package:ny_times_app/screens/ArticleDetailScreen.dart';
import '../blocs/article_bloc.dart';
import '../models/article_model.dart';

class ArticleListScreen extends StatefulWidget {
  @override
  _ArticleListScreenState createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  final ScrollController _scrollController = ScrollController();
  final int incrementCount = 10;
  int itemCount = 10;
  late ArticleBloc _articleBloc;

  @override
  void initState() {
    super.initState();

    locator.get<ArticleBloc>().fetchArticles();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          itemCount += incrementCount;
          locator.get<ArticleBloc>().fetchArticles();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NY Times Most Popular',
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
        backgroundColor: const Color.fromRGBO(147, 223, 196, 1),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: BlocBuilder<ArticleBloc, List<Article>>(
        builder: (context, articles) {
          if (articles.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              itemCount = incrementCount;
              locator.get<ArticleBloc>().fetchArticles();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  articles.length < itemCount ? articles.length : itemCount + 1,
              itemBuilder: (context, index) {
                if (index == itemCount) {
                  return _buildProgressIndicator();
                } else {
                  final article = articles[index];
                  return Center(
                    child: ListTile(
                      leading: Icon(
                        Icons.circle,
                        size: 40,
                      ),
                      title: Text(article.title),
                      subtitle: Expanded(
                        child: Text(article.byline,
                            maxLines: 1, textAlign: TextAlign.left),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                      contentPadding: EdgeInsets.all(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ArticleDetailScreen(article: article),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _articleBloc.close();
    super.dispose();
  }
}

Widget _buildProgressIndicator() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Center(child: CircularProgressIndicator()),
  );
}
