import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/constants/constants.dart';
import 'package:movie_app/features/movies/data/models/movie.dart';
import 'package:movie_app/features/movies/presentation/presentation.dart';

class MoviesDetailsScreen extends StatelessWidget {
  const MoviesDetailsScreen({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.backgroundImageOriginal,
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            BlocProvider(
              create: (context) => MoviesSuggestionsCubit(
                const MoviesSuggestionsState(),
                httpClient: http.Client(),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Movie Info',
                        style: TextStyle(
                          fontSize: 20,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      movie.summary,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'You would also like these',
                        style: TextStyle(
                            fontSize: 20,
                            color: kTextColor,
                            fontWeight: FontWeight.bold,),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: BlocBuilder<MoviesSuggestionsCubit,
                          MoviesSuggestionsState>(
                        builder: (context, state) {
                          switch (state.status) {
                            case MoviesSuggestionStatus.initial:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case MoviesSuggestionStatus.success:
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://yts.mx/assets/images/movies/frida_kahlo_2020/medium-cover.jpg',
                                        height: double.infinity,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              );
                            case MoviesSuggestionStatus.failure:
                              return const Center(
                                child: Text('Something went wrong'),
                              );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
