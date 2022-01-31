import 'package:flutter/material.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Movies'),
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://yts.mx/assets/images/movies/frida_kahlo_2020/medium-cover.jpg',
                            height: 200,
                            width: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Movie Title',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Action, War',
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  'Who was Frida Kahlo? Everyone knows her, but who was the woman behind the bright colours, the big brows, and the floral crowns? Take a journey through the life of a true icon, discover her art, and uncover the truth behind her often turbulent life.',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(color: Colors.white),
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
