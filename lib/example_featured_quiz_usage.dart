import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Components/featured_quiz_card.dart';

class ExampleFeaturedQuizUsage extends StatelessWidget {
  const ExampleFeaturedQuizUsage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Quizzes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            FeaturedQuizCard(
              categoryName: 'Math',
              icon: FontAwesomeIcons.calculator,
              color: Colors.blue,
              questionCount: '25 Questions',
              rating: '4.8',
              imagePath: 'assets/math.jpg',
              onPlay: () {
                // Handle play action
              },
            ),
            FeaturedQuizCard(
              categoryName: 'Music',
              icon: FontAwesomeIcons.music,
              color: Colors.purple,
              questionCount: '20 Questions',
              rating: '4.6',
              imagePath: 'assets/music.jpg',
              onPlay: () {
                // Handle play action
              },
            ),
            FeaturedQuizCard(
              categoryName: 'Places',
              icon: FontAwesomeIcons.locationDot,
              color: Colors.green,
              questionCount: '30 Questions',
              rating: '4.7',
              imagePath: 'assets/place.jpg',
              onPlay: () {
                // Handle play action
              },
            ),
            FeaturedQuizCard(
              categoryName: 'Toys',
              icon: FontAwesomeIcons.gamepad,
              color: Colors.orange,
              questionCount: '15 Questions',
              rating: '4.5',
              imagePath: 'assets/toys.jpg',
              onPlay: () {
                // Handle play action
              },
            ),
            FeaturedQuizCard(
              categoryName: 'Language',
              icon: FontAwesomeIcons.language,
              color: Colors.red,
              questionCount: '22 Questions',
              rating: '4.9',
              imagePath: 'assets/language.jpg',
              onPlay: () {
                // Handle play action
              },
            ),
            FeaturedQuizCard(
              categoryName: 'Science',
              icon: FontAwesomeIcons.flask,
              color: Colors.teal,
              questionCount: '28 Questions',
              rating: '4.7',
              imagePath: 'assets/science.jpg',
              onPlay: () {
                // Handle play action
              },
            ),
          ],
        ),
      ),
    );
  }
}
