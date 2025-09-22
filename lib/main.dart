import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_user_screen.dart';
import 'screens/books_list_screen.dart';
import 'screens/book_details_screen.dart';
import 'screens/add_book_screen.dart';
import 'screens/edit_book_screen.dart';
import 'screens/authors_list_screen.dart';
import 'screens/add_author_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/about_screen.dart';
import 'screens/edit_author_screen.dart';
import 'providers/user_provider.dart';
import 'providers/book_provider.dart';
import 'providers/author_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => AuthorProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// ...existing code...
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Readed',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3A86FF),
          primary: const Color(0xFF3A86FF),
          background: const Color(0xFF0D1B2A),
          onPrimary: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Color(0xFFE0E1DD)),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D1B2A),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3A86FF),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterUserScreen(),
        '/books': (context) => const BooksListScreen(),
        '/bookDetails': (context) => const BookDetailsScreen(),
        '/addBook': (context) => const AddBookScreen(),
        '/editBook': (context) => const EditBookScreen(),
        '/authors': (context) => const AuthorsListScreen(),
        '/authorsList': (context) => const AuthorsListScreen(),
        '/addAuthor': (context) => const AddAuthorScreen(),
        '/editAuthor': (context) => const EditAuthorScreen(),
        '/profile': (context) => const UserProfileScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
