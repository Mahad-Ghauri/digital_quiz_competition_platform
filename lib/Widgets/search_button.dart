import 'package:digital_quiz_competition_platform/Utils/navigation_helper.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final Color? color;
  final double size;
  
  const SearchButton({
    Key? key,
    this.color,
    this.size = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search_rounded,
        color: color ?? Colors.purpleAccent,
        size: size,
      ),
      onPressed: () => NavigationHelper.navigateToSearchPage(context),
      tooltip: 'Search Quizzes',
    );
  }
}

class SearchFAB extends StatelessWidget {
  const SearchFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => NavigationHelper.navigateToSearchPage(context),
      backgroundColor: Colors.purpleAccent,
      child: const Icon(Icons.search_rounded),
      tooltip: 'Search Quizzes',
    );
  }
}