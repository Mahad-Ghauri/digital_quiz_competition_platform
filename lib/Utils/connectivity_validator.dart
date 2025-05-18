import 'dart:async';
import 'package:flutter/material.dart';

class ConnectivityValidator {
  // Check if device is connected to the internet
  static Future<bool> isConnected() async {
    // This is a mock implementation
    // In a real app, you would use a package like connectivity_plus
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
  
  // Show no internet connection dialog
  static Future<void> showNoConnectionDialog(
    BuildContext context, {
    required VoidCallback onRetry,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
            'Please check your internet connection and try again.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
            ),
          ],
        );
      },
    );
  }
  
  // Listen for connectivity changes
  static StreamSubscription<bool>? _subscription;
  
  // Start listening for connectivity changes
  static void startListening(Function(bool) onConnectivityChanged) {
    // This is a mock implementation
    // In a real app, you would use a package like connectivity_plus
    _subscription = Stream.periodic(
      const Duration(seconds: 5),
      (_) => true,
    ).listen(onConnectivityChanged);
  }
  
  // Stop listening for connectivity changes
  static void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}