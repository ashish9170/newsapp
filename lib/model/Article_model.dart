class ArticleModel {
  late String title;
  late String? author;
  late String description;
  late String urlToImage;
  late String? content;
  late String url;

  ArticleModel({
    required this.title,
    required this.url,
    required this.description,
    required this.urlToImage,
    required this.author,
    required this.content,
  });
}
