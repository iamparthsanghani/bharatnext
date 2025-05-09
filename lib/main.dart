import 'package:bharatnxrassignmentnext/blocs/articles/article_bloc.dart';
import 'package:bharatnxrassignmentnext/blocs/articles/article_event.dart';
import 'package:bharatnxrassignmentnext/data/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/repositories/article_repository.dart';
import 'screens/home_screen.dart';
import 'utils/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());
  await Hive.openBox('favorites');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ArticleRepository(),
      child: BlocProvider(
        create: (context) =>
        ArticleBloc(repository: context.read<ArticleRepository>())
          ..add(FetchArticles()),
        child: MaterialApp(
          title: 'Articles App',
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
