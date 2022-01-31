import 'package:flutter/material.dart';
import 'package:movie_app/app/constants/constants.dart';
import 'package:movie_app/features/movies/presentation/presentation.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: kPrimaryColor),
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      home: const MoviesScreen(),
    );
  }
}
