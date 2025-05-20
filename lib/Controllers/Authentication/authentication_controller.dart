// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:digital_quiz_competition_platform/Views/Authentication/login_screen.dart';
import 'package:digital_quiz_competition_platform/Views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationController {
  //  SUPABASE INSTANCE
  final supabase = Supabase.instance.client;

  //  Method to Log the user into the Application
  Future<void> signInWithEmailPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await supabase.auth
          .signInWithPassword(email: email, password: password)
          .onError((error, stackTrace) {
        log("Error: $error");
        throw Exception("Error Occurred!");
      });

      if (response.session != null) {
        //  If the user is logged in, we can redirect them to the home page
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const Dashboard()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Center(child: Text('Logged In Successfully')),
            behavior: SnackBarBehavior.floating,
          ),
        );
        log(response.session.toString());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error: Unable to login'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (error) {
      log(error.toString());
    }
  }

  //  Method to create a new user and log into the Application
  Future<void> signUpWithEmailPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await supabase.auth
          .signUp(email: email, password: password)
          .then((value) {
        //  If the user is signed up, we can redirect them to the home page
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Center(
              child: Text(
                'Welcome to Quizizen! \n Please Login to Continue',
              ),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error: Unable to Sign Up'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        log("Error: $error");
        throw Exception("Error Occurred!");
      });
    } catch (error) {
      log(error.toString());
    }
  }

  //  Method to End the current session and log the user out of the application
  Future<void> signOutAndEndSession(BuildContext context) async {
    try {
      await supabase.auth.signOut().then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        ); //  Redirect the user to the login page
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Thanks For Using Our Services. See you Soon!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error: Unable to Sign Out'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        log("Error: $error");
        throw Exception("Error Occurred!");
      });
    } catch (error) {
      log(error.toString());
    }
  }

  //  Method for restoring password
  Future<void> restorePassword(String email, BuildContext context) async {
    final navigator = Navigator.of(context);
    try {
      await supabase.auth.resetPasswordForEmail(email).then((value) {
        log("Password Reset Link Sent");
        showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Password Reset'),
            content: const Text(
              'A password reset link has been sent to your email',
            ),
            actions: [
              ElevatedButton(
                onPressed: () => navigator.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Dismiss",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ],
          ),
        );
      }).onError((error, stackTrace) {
        log("Error: $error");
        throw Exception("Error Occurred!");
      });
    } catch (error) {
      log(error.toString());
    }
  }

  //  Getting current User email
  String? getCurrentUserEmail() {
    final session = supabase.auth.currentSession;
    if (session != null) {
      return session.user.email;
    } else {
      return "Error: No Session Found";
    }
  }
}
