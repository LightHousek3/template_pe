import 'package:flutter/material.dart';
import 'package:slot14_sqflite/db/database_initializer.dart';
import 'package:slot14_sqflite/routes/app_routes.dart';
import 'package:slot14_sqflite/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseInitializer.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Art Gallery Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00897B)),
        scaffoldBackgroundColor: const Color(0xFFF4F8FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF4F8FA),
          elevation: 0,
          centerTitle: false,
          foregroundColor: Color(0xFF102027),
          titleTextStyle: TextStyle(
            color: Color(0xFF102027),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF00897B)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00897B),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      routes: AppRoutes.routes,
      home: const SplashScreen(),
    );
  }
}
