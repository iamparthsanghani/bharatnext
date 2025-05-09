import 'package:bharatnxrassignmentnext/blocs/articles/article_bloc.dart';
import 'package:bharatnxrassignmentnext/blocs/articles/article_event.dart';
import 'package:bharatnxrassignmentnext/blocs/articles/article_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/article_card.dart';
import 'article_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Articles')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) =>
                  context.read<ArticleBloc>().add(SearchArticles(value)),
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ArticleBloc, ArticleState>(
              builder: (context, state) {
                if (state is ArticleLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ArticleLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ArticleBloc>().add(FetchArticles());
                    },
                    child: ListView.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        final article = state.articles[index];
                        return ArticleCard(
                          article: article,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ArticleDetailScreen(article: article),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else if (state is ArticleError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
