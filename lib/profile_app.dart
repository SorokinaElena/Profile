import 'package:flutter/material.dart';
import 'package:profile/profile.dart';


class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 166, 197, 227),
        ),
        checkboxTheme: const CheckboxThemeData().copyWith(
          checkColor: const WidgetStatePropertyAll(
            Color.fromARGB(255, 73, 83, 92),
          ),
        ),
        /* textTheme: const TextTheme().copyWith(
          bodyMedium: TextStyle(

          ),
        ), */
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color.fromARGB(97, 0, 0, 0),
            ),
          ),
          hintStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            color: Color.fromARGB(97, 0, 0, 0),
          ),
          /* labelStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: Color.fromARGB(255, 110, 28, 28),
          ), */
          errorStyle: const TextStyle().copyWith(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: const Color.fromARGB(255, 110, 28, 28),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: const ButtonStyle().copyWith(
            textStyle: const WidgetStatePropertyAll(
              TextStyle(fontSize: 18),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: const ButtonStyle().copyWith(
            textStyle: const WidgetStatePropertyAll(
              TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
      home: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 166, 197, 227),
                Color.fromARGB(255, 233, 242, 243),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: const Profile(),
        ),
      ),
    );
  }
}
