import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ArticleRepository {
  Future<List<ArticleModel>> fetchArticles() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((json) => ArticleModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
