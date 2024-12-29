import 'package:flutter/material.dart';
import 'package:music_level/components/auth_parts/email_password_widget.dart';
import 'package:music_level/components/auth_parts/google_button.dart';
import 'package:music_level/services/appwrite_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final appwriteService = AppwriteService();

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
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text color
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Using EmailPasswordWidget with isSignUp: false for Login
                  const EmailPasswordWidget(isSignUp: false),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white), // White text
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the Sign Up page
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.amber, // Button color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: const Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GoogleButton(
                    onPressed: () async {
                       appwriteService.continueWithGoogle().then((value) {
                              if (value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Google Login Successful",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.green.shade400,
                                ));
                                Navigator.pushReplacementNamed(
                                    context, "/");
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Google Login Failed",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red.shade400,
                                ));
                              }
                            });
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
