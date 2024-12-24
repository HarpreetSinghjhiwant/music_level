import 'package:flutter/material.dart';
import 'package:music_level/services/appwrite_service.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final AppwriteService appwriteService = AppwriteService();

  Future<bool> checkUserLoggedIn() async {
    final user = await appwriteService.getCurrentUser();
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while checking login state
          return Scaffold(
            backgroundColor: Colors.black,
            body: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        } else if (snapshot.hasError || snapshot.data == false) {
          // If not logged in, navigate to login page
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
        } else {
          // If logged in, navigate to the main page
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/');
          });
        }

        return const SizedBox.shrink(); // Placeholder widget
      },
    );
  }
}
