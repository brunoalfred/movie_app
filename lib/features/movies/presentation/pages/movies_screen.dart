import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (context) =>
                                    const MoviesDetailsScreen(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://yts.mx/assets/images/movies/frida_kahlo_2020/medium-cover.jpg',
                              height: 200,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Movie Title',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Action, War',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'Ratings: 2.35',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(color: kSecondaryColor),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'Language: en',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(color: kSecondaryColor),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (context) =>
                                            const MoviesDetailsScreen(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      kAssetPrimaryColor,
                                    ),
                                  ),
                                  child: const Text(
                                    'View Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
