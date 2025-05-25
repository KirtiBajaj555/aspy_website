import 'package:flutter/material.dart';

class AppTheme {
  /// **🌟 Main Theme Configuration**
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.transparent, // Allows global gradient background
      primarySwatch: Colors.purple,
      fontFamily: 'Poppins', // Set global font

      /// **🌟 Text Theme (Basic Styling)**
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  /// **🎨 Global Diagonal Gradient Background**
  static BoxDecoration get backgroundGradient {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 210, 217, 248),
          Color.fromARGB(255, 240, 200, 252), // Light Purple
          Color.fromARGB(255, 248, 215, 231), // Soft Pink
          Color.fromARGB(255, 197, 250, 250),
        ],
      ),
      backgroundBlendMode: BlendMode.softLight, // Soft effect
    );
  }
}