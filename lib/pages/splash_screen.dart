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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50), // Circular border
                    child: Image.asset(
                      'assets/icon.jpg', // Replace with your logo path
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.width * 0.45,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Music Level',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError || snapshot.data == false) {
          // If not logged in, navigate to login page
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          });
        } else if (snapshot.hasData && snapshot.data == true) {
          // If logged in, navigate to the main page
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/');
            }
          });
        }

        return const SizedBox.shrink(); // Placeholder widget
      },
    );
  }
}
