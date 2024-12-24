import 'package:flutter/material.dart';
import 'package:music_level/components/auth_parts/email_password_widget.dart';
import 'package:music_level/components/auth_parts/google_button.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50), // Circular border
                      child: Image.asset(
                      'assets/icon.jpg', // Replace with your logo path
                      width: 100,
                      height: 100,
                      ),
                    ),
                    ),
                    const SizedBox(height: 24),
                  Center(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text color
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Using EmailPasswordWidget with isSignUp: true for Sign Up
                  const EmailPasswordWidget(isSignUp: true),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.white), // White text
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the Login page
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.amber, // Button color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GoogleButton(
                    onPressed: () {
                      // Handle Google sign-up logic here
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}