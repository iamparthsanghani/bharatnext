// article_event.dart
abstract class ArticleEvent {}
class FetchArticles extends ArticleEvent {}
class SearchArticles extends ArticleEvent {
  final String query;
  SearchArticles(this.query);
}
