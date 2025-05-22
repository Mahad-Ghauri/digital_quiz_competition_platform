// import 'package:digital_quiz_competition_platform/Controllers/search_controller.dart';
// import 'package:digital_quiz_competition_platform/Services/supabase_service.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/single_child_widget.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AppProviders {
//   static List<SingleChildWidget> providers = [
//     // Services
//     Provider<SupabaseService>(
//       create: (_) => SupabaseService(Supabase.instance.client),
//     ),
    
//     // Controllers
//     ChangeNotifierProvider<QuizSearchController>(
//       create: (context) => QuizSearchController(
//         supabaseService: context.read<SupabaseService>(),
//       ),
//     ),
//   ];
// }