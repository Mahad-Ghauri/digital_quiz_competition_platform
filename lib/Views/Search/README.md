# Search Functionality

This directory contains the implementation of the search functionality for the Digital Quiz Competition Platform.

## Features

- Search quizzes by title, description, or category
- Filter quizzes by category
- Real-time search results
- Beautiful UI with animations
- Loading, error, and empty states

## How to Use

### 1. Access the Search Page

The search page is accessible in two ways:

- From the bottom navigation bar (Search tab)
- Using the `NavigationHelper` from anywhere in the app:

```dart
import 'package:digital_quiz_competition_platform/Utils/navigation_helper.dart';

// Navigate to search page
NavigationHelper.navigateToSearchPage(context);
```

### 2. Add a Search Button to Any Screen

You can add a search button to any screen using the `SearchButton` widget:

```dart
import 'package:digital_quiz_competition_platform/Widgets/search_button.dart';

// In your AppBar actions
AppBar(
  title: Text('My Screen'),
  actions: [
    const SearchButton(),
  ],
)
```

Or add a Floating Action Button:

```dart
import 'package:digital_quiz_competition_platform/Widgets/search_button.dart';

// In your Scaffold
Scaffold(
  floatingActionButton: const SearchFAB(),
)
```

### 3. Customize the Search Experience

The search functionality is powered by the `QuizSearchController` which is already registered as a provider in the app. You can access it from anywhere using:

```dart
final searchController = Provider.of<QuizSearchController>(context);
// or
final searchController = context.read<QuizSearchController>();
```

## Implementation Details

- `search_page.dart`: The main search UI
- `QuizSearchController`: Manages search state and operations
- `SupabaseService`: Handles data fetching from Supabase

## Supabase Integration

The search functionality uses Supabase to fetch and filter quizzes. The implementation includes:

- Fetching all quizzes
- Searching quizzes by title, description, or category
- Filtering quizzes by category

For testing purposes, mock data is currently used. To switch to the actual Supabase implementation, uncomment the Supabase code in `SupabaseService` and comment out the mock data code.