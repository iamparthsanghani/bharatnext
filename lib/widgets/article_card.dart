import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../data/models/article_model.dart';
import 'package:hive/hive.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onTap;

  const ArticleCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final favoritesBox = Hive.box('favorites');
    final isFavorite = favoritesBox.containsKey(article.id);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(article.title),
        subtitle: Text(
          article.body.length > 50 ? '${article.body.substring(0, 50)}...' : article.body,
        ),
        onTap: onTap,
        trailing: ValueListenableBuilder(
          valueListenable: favoritesBox.listenable(),
          builder: (context, Box box, _) {
            final isFavorite = box.containsKey(article.id);

            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                if (isFavorite) {
                  box.delete(article.id);
                } else {
                  box.put(article.id, article);
                }
              },
            );
          },
        )

      ),
    );
  }
}
