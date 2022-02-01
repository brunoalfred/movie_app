import 'package:flutter/material.dart';
import 'package:movie_app/app/constants/constants.dart';

class MoviesDetailsScreen extends StatelessWidget {
  const MoviesDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
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
                'https://yts.mx/assets/images/movies/frida_kahlo_2020/background.jpg',
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    'Who was Frida Kahlo? Everyone knows her, but who was the woman behind the bright colours, the big brows, and the floral crowns? Take a journey through the life of a true icon, discover her art, and uncover the truth behind her often turbulent life. Making use of the latest technology to deliver previously unimaginable quality, we take an in-depth look at key works throughout her career. Using letters Kahlo wrote to guide us, this definitive film reveals her deepest emotions and unlocks the secrets and symbolism contained within her art. Exhibition on Screens trademark combination of interviews, commentary and a detailed exploration of her art delivers a treasure trove of colour and a feast of vibrancy. This personal and intimate film offers privileged access to her works, and highlights the source of her feverish creativity, her resilience, and her unmatched lust for life, politics, men and women. Delving deeper than any film has done before, engaging with world-renowned Kahlo experts, exploring how great an artist she was, discover the real Frida Kahlo.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'You would also like these',
                      style: TextStyle(
                          fontSize: 20,
                          color: kTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
