class Article {
  final String title;
  final String byline;
  final String url;
  // final String publishedDate;

  Article({
    required this.title,
    required this.byline,
    required this.url,
    // required this.publishedDate
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      byline: json['byline'],
      url: json['url'],
      // publishedDate: json['publishedDate'],
    );
  }
}
