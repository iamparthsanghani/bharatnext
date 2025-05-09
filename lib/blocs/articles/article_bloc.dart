// article_bloc.dart
import 'package:bharatnxrassignmentnext/data/models/article_model.dart';
import 'package:bharatnxrassignmentnext/data/repositories/article_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository repository;
  List<ArticleModel> _allArticles = [];

    ArticleBloc({required this.repository}) : super(ArticleInitial()) {
    on<FetchArticles>((event, emit) async {
      emit(ArticleLoading());
      try {
        _allArticles = await repository.fetchArticles();
        emit(ArticleLoaded(_allArticles));
      } catch (e) {
        emit(ArticleError(e.toString()));
      }
    });

    on<SearchArticles>((event, emit) {
      final filtered = _allArticles.where((article) =>
      article.title.toLowerCase().contains(event.query.toLowerCase()) ||
          article.body.toLowerCase().contains(event.query.toLowerCase())
      ).toList();
      emit(ArticleLoaded(filtered));
    });
  }
}
