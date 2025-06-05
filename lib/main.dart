import 'package:flutter/material.dart';
import 'home.dart';
import 'settings_page.dart';
import 'search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const beige = Color(0xFFE0E1DD);
  static const lightBlue = Color(0xFF778DA9);
  static const midBlue = Color(0xFF415A77);
  static const darkBlue = Color(0xFF1B263B);

  // This widget is the root of the application
  // Below is some basic themes and important page locations
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astronomy Weather App',
      theme: ThemeData(
        scaffoldBackgroundColor: lightBlue,
        colorScheme: const ColorScheme.dark(
            primary: lightBlue,
            onPrimary: beige,
            primaryContainer: midBlue,
            onPrimaryContainer: beige,
            secondaryContainer: darkBlue,
            onSecondaryContainer: beige,
            outline: beige
        ),
        fontFamily: 'Helvetica',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: 'Weather'),
        '/settings': (context) => SettingsPage(),
        '/location': (context) => const LocPage(title: 'Locate'),
      },
    );
  }
}

