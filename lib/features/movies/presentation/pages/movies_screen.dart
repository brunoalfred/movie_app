import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:movie_app/app/constants/constants.dart';
import 'package:movie_app/features/movies/presentation/presentation.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Kigamboni Cinemax',
          style: TextStyle(
            color: kTextColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => MoviesBloc(httpClient: http.Client())
          ..add(
            const MoviesFetched(),
          ),
        child: const MoviesList() ,
      ),
    );
  }
}
