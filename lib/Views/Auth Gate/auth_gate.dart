// ignore_for_file: deprecated_member_use

import 'package:digital_quiz_competition_platform/Controllers/Authentication/authentication_controller.dart';
// import 'package:digital_quiz_competition_platform/Views/Interface/interface_page.dart';
import 'package:digital_quiz_competition_platform/Views/Interface/onboarding.dart';
import 'package:digital_quiz_competition_platform/Views/dashboard.dart';
// import 'package:digital_quiz_competition_platform/Views/Interface/question_page.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthenticationController().supabase.auth.onAuthStateChange,
      //  Build Appropeiate Page according to the auth state
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                  color: Colors.purpleAccent.withOpacity(0.8)),
            ),
          );
        }

        //  Checking if there exists any valid session
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return const Dashboard();
        } else {
          return const Onboarding();
        }
      },
    );
  }
}
