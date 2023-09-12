
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Article_model.dart';

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async{
  String url =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=dedca1c92e2d4ff8a3370781ef9cf838";
  var response = await http.get(Uri.parse(url));


  var jsonData = jsonDecode(response.body);

  if(jsonData['status'] == "ok"){
    jsonData["articles"].forEach((element){

      if(element['urlToImage'] != null && element['description'] != null){
        ArticleModel article = ArticleModel(
          title: element['title'],
          author: element['author'],
          description: element['description'],
          urlToImage: element['urlToImage'],
          content: element["content"],
          url: element["url"],
        );
        news.add(article);
      }

    });
  }
  }
}
class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async{
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=dedca1c92e2d4ff8a3370781ef9cf838";
    var response = await http.get(Uri.parse(url));


    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel article = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }

      });
    }
  }
}
