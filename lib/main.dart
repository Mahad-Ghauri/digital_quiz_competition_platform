// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:digital_quiz_competition_platform/Controllers/search_controller.dart';
import 'package:digital_quiz_competition_platform/Providers/quiz_provider.dart';
import 'package:digital_quiz_competition_platform/Providers/theme_provider.dart';
import 'package:digital_quiz_competition_platform/Providers/user_profile_provider.dart';
import 'package:digital_quiz_competition_platform/Providers/language_provider.dart';
import 'package:digital_quiz_competition_platform/Providers/notification_provider.dart';
import 'package:digital_quiz_competition_platform/Providers/sound_provider.dart';
import 'package:digital_quiz_competition_platform/Providers/leaderboard_provider.dart';
import 'package:digital_quiz_competition_platform/Services/supabase_service.dart';
import 'package:provider/provider.dart';
import 'package:digital_quiz_competition_platform/Utils/consts.dart';
import 'package:digital_quiz_competition_platform/Views/dashboard.dart';
import 'package:digital_quiz_competition_platform/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  //  Initialize the Widget Binding
  WidgetsFlutterBinding.ensureInitialized();

  //  Firebase Setup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    log("Firebase Setup Completed. Initializing Supabase");
    //  Supabase Setup
    Supabase.initialize(url: url, anonKey: anonKey).then((value) {
      log("Supabase initialization completed. Running the application");

      //  Run the application
      // Create Supabase service
      final supabaseService = SupabaseService(Supabase.instance.client);

      runApp(
        MultiProvider(
          providers: [
            // Services
            Provider<SupabaseService>.value(value: supabaseService),

            // Providers
            ChangeNotifierProvider(create: (context) => QuizProvider()),
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => UserProfileProvider()),
            ChangeNotifierProvider(create: (context) => LanguageProvider()),
            ChangeNotifierProvider(create: (context) => NotificationProvider()),
            ChangeNotifierProvider(create: (context) => SoundProvider()),
            ChangeNotifierProvider(create: (context) => LeaderboardProvider()),

            // Controllers
            ChangeNotifierProvider(
              create: (context) => QuizSearchController(
                supabaseService: supabaseService,
              ),
            ),
          ],
          child: const MyApp(),
        ),
      );
      // runApp(const MyApp());
    }).onError((error, stackTrace) {
      log("Supabase initialization failed; $error");
    });
  }).onError((error, stackTrace) {
    log("Firebase initialization failed; $error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      title: 'Quizizen',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme(),
      home: const Dashboard(),
    );
  }
}
