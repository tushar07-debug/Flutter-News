import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news =[];

  Future<void> getNews() async{
    String url="https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=b78718d2f1d84dd6a330041de0b2cf61";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element['description'] != null)
          {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["context"]
            );

            news.add(articleModel);
          }
      });
    }
  }
}