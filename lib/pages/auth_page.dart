import 'package:flutter/material.dart';
import 'package:music_level/components/auth_parts/apple_button.dart';
import 'package:music_level/components/auth_parts/google_button.dart';
import 'package:music_level/components/auth_parts/microsoft_button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Image.asset(
            'assets/logo.png', // Replace with your logo path
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 24), // Space below logo

          // Title
          Text(
            'Continue as',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40), // Space below title

          // Authentication Buttons
          GoogleButton(
              onPressed: () async {
                
              },
            ),

          MicrosoftButton(
            onPressed: () async {
              // Handle Microsoft sign-in
            },
          ),

          AppleButton(
            onPressed: () async {
              // Handle Apple sign-in
            },
          ),
        ],
      ),
    );
  }
}
