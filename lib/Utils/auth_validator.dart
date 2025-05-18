import 'package:flutter/material.dart';

class AuthValidator {
  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    // This is a mock implementation
    // In a real app, you would check with your auth service
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
  
  // Show authentication required dialog
  static Future<void> showAuthRequiredDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Authentication Required'),
          content: const Text(
            'You need to be logged in to view the leaderboard. '
            'Please log in or create an account to continue.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to previous screen
              },
            ),
            TextButton(
              child: const Text('Log In'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to login screen
                // Navigator.of(context).pushNamed('/login');
              },
            ),
          ],
        );
      },
    );
  }
}