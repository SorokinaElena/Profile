import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
//import 'package:profile/new_profile_info.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 166, 197, 227),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color.fromARGB(97, 0, 0, 0),
            ),
          ),
        ),
      ),
      home: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(5, 60, 5, 10),
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
