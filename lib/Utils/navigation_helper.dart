import 'package:digital_quiz_competition_platform/Views/Search/search_page.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  // Navigate to search page
  static void navigateToSearchPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchPage()),
    );
  }

  // Add more navigation methods as needed
}
