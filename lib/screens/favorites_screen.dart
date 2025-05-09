import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/models/article_model.dart';
import 'article_detail_screen.dart';
import '../widgets/article_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesBox = Hive.box('favorites');
    final favorites = favoritesBox.values.cast<ArticleModel>().toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final article = favorites[index];
          return ArticleCard(
            article: article,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArticleDetailScreen(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
